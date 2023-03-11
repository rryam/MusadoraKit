//
//  CatalogStation.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit
import Foundation

public extension MCatalog {
  /// Fetch a station from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the station.
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
  /// - Parameters:
  ///   - ids: The unique identifier for the stations.
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

public extension MCatalog {
  /// Fetch a list of stations in the current country's storefront that belong to a specific station genre in the Apple Music catalog.
  ///
  /// - Parameter genre: The `StationGenre` object representing the genre for which to retrieve the stations.
  /// - Returns: `Stations` representing the list of stations belonging to the specified genre.
  static func stations(for genre: StationGenre) async throws -> Stations {
    let storefront = try await MusicDataRequest.currentCountryCode

    let url = URL(string: "https://api.music.apple.com/v1/catalog/\(storefront)/station-genres/\(genre.id.rawValue)/stations")

    guard let url = url else {
      throw URLError(.badURL)
    }

    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()

    let stations = try JSONDecoder().decode(Stations.self, from: response.data)
    return stations
  }

  /// Fetch a list of stations in the current country's storefront that belongs to all station genres in the Apple Music catalog.
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
}
