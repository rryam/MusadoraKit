//
//  "I wish I was irrational like you,
//  So I could fulfil your wish, too,
//  If you were the one for me,
//  Why was it just glimpse of us to see?"
//
//  CatalogStation.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 14/08/21.
//

import Foundation

public extension MCatalog {

  /// Fetch a station from the Apple Music catalog by using its identifier.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let station = try await MCatalog.station(id: "12345678")
  ///       print(station.name)
  ///     } catch {
  ///       print("Error fetching station: (error.localizedDescription)")
  ///     }
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the station.
  ///
  /// - Returns: `Station` matching the given identifier.
  static func station(id: MusicItemID) async throws -> Station {
    let request = MusicCatalogResourceRequest<Station>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let station = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return station
  }

  /// Fetch multiple stations from the Apple Music catalog by using their identifiers.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let stationIds = ["12345678", "23456789", "34567890"]
  ///       let stations = try await MCatalog.stations(ids: stationIds)
  ///
  ///       print(stations)
  ///     } catch {
  ///       print("Error fetching stations: (error.localizedDescription)")
  ///     }
  ///
  /// - Parameters:
  ///   - ids: The unique identifier for the stations.
  ///
  /// - Returns: `Stations` matching the given identifiers.
  static func stations(ids: [MusicItemID]) async throws -> Stations {
    let request = MusicCatalogResourceRequest<Station>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return response.items
  }

  /// Fetch the streaming and editorial stations of Apple Music.
  /// - Returns: `Stations` by Apple Music.
  ///
  /// Thanks to [Daniel Steinberg](https://dimsumthinking.com)!
  @available(*, message: "This method is fragile. I have already filed a feedback (FB12018181) to provide the `kind` property which is better for identifying the stations by Apple Music.")
  static func appleStations() async throws -> Stations {
    try await withThrowingTaskGroup(of: Stations.self) { group in
      let searchTerms = ["Apple Music", "Stations", "Station"]
      var applestations: Stations = []

      for searchTerm in searchTerms {
        group.addTask {
          return try await MCatalog.searchStations(for: searchTerm, limit: 25)
        }
      }

      for try await stations in group {
        applestations += stations
      }

      let appleStreamingStations = applestations.filter { station in
        return station.name.starts(with: "Apple Music")
      }

      let appleEditorialStations = applestations.filter { station in
        guard let tagline = station.editorialNotes?.tagline else {
          return false
        }

        return tagline.starts(with: "Apple Music")
      }

      let allAppleStations = appleEditorialStations + appleStreamingStations
      let stations: Set<Station> = Set(allAppleStations)
      return MusicItemCollection(stations)
    }
  }
}

// MARK: - Genre Stations.
public extension MCatalog {

  /// Fetch a list of stations in the current country's storefront that belong to a specific station genre in the Apple Music catalog.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let genre = try await MCatalog.genre(id: "34")
  ///       let stations = try await MCatalog.stations(for: genre)
  ///
  ///       for station in stations {
  ///         print(station.name)
  ///       }
  ///     } catch {
  ///       print("Error fetching stations: (error.localizedDescription)")
  ///     }
  ///
  /// - Parameters:
  ///   - genre: The `StationGenre` object representing the genre for which to retrieve the stations.
  ///
  /// - Returns: `Stations` representing the list of stations belonging to the specified genre.
  static func stations(for genre: StationGenre) async throws -> Stations {
    let storefront = try await MusicDataRequest.currentCountryCode
    let url = try stationsURL(for: genre.id, storefront: storefront)

    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()

    let stations = try JSONDecoder().decode(Stations.self, from: response.data)
    return stations
  }

  /// Fetch a list of stations in the current country's storefront that belongs to all station
  /// genres in the Apple Music catalog.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let countryStations = try await MCatalog.allCountryStations()
  ///       for station in countryStations {
  ///         print(station.name)
  ///       }
  ///     } catch {
  ///       print("Error fetching stations: (error.localizedDescription)")
  ///     }
  ///
  /// - Returns: `Stations` representing the list of stations belonging to all the station genres.
  static func allCountryStations() async throws -> Stations {
    try await withThrowingTaskGroup(of: Stations.self) { group in
      let stationGenres = try await MCatalog.stationGenres()
      var allCountryStations: Stations = []

      for genre in stationGenres {
        group.addTask {
          return try await stations(for: genre)
        }
      }

      for try await stations in group {
        allCountryStations += stations
      }

      return allCountryStations
    }
  }

  internal static func stationsURL(for id: MusicItemID, storefront: String) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(storefront)/station-genres/\(id.rawValue)/stations"

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}

// MARK: - Personal Stations.
public extension MCatalog {

  /// Fetch the user's personalized Apple Music station.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let personalStation = try await MCatalog.personalStation()
  ///
  ///       print(personalStation.name) // "Rudrank Riyam's Station"
  ///     } catch {
  ///       print("Error fetching personal station: \(error.localizedDescription)")
  ///     }
  ///
  /// - Returns: `Station` object representing the user's personalised Apple Music station.
  static func personalStation() async throws -> Station {
    let stations: Stations
    let storefront = try await MusicDataRequest.currentCountryCode
    let url = try personalStationURL(for: storefront)
    let decoder = JSONDecoder()

    if let userToken = MusadoraKit.userToken {
      let request = MUserRequest(urlRequest: .init(url: url), userToken: userToken)
      let data = try await request.response()
      stations = try decoder.decode(Stations.self, from: data)
    } else {
      let request = MusicDataRequest(urlRequest: URLRequest(url: url))
      let response = try await request.response()
      stations = try decoder.decode(Stations.self, from: response.data)
    }

    guard let personalStation = stations.first else {
      throw MusadoraKitError.notFound(for: "personal radio station")
    }

    return personalStation
  }

  internal static func personalStationURL(for storefront: String) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(storefront)/stations"
    components.queryItems = [URLQueryItem(name: "filter[identity]", value: "personal")]

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}

// MARK: - Live Radio Stations.
public extension MCatalog {

  /// Fetch the list of featured Apple Music live radio stations.
  ///
  /// This method retrieves the current list of featured live radio stations available
  /// on Apple Music.
  ///
  /// As of writing this method, there are three live stations available:  **Apple Music 1**,
  /// **Apple Music Hits** and **Apple Music Country**.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let stations = try await MCatalog.liveStations()
  ///       print(stations) // Stations(Apple Music 1, Apple Music Hits, Apple Music Country)
  ///     } catch {
  ///       print("Error fetching live stations: \(error.localizedDescription)")
  ///     }
  ///
  /// - Returns: `Stations` representing the featured Apple Music live radio stations.
  static func liveStations() async throws -> Stations {
    let storefront = try await MusicDataRequest.currentCountryCode
    let url = try liveStationsURL(for: storefront)

    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()
    let stations = try JSONDecoder().decode(Stations.self, from: response.data)
    return stations
  }

  internal static func liveStationsURL(for storefront: String) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(storefront)/stations"
    components.queryItems = [URLQueryItem(name: "filter[featured]", value: "apple-music-live-radio")]

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
