//
//  MRecommendation+default.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//

public extension MRecommendation {

  /// Retrieve the default recommendations for a user.
  ///
  /// The recommendations are determined based
  /// on the user's past interactions and preferences.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let recommendations = try await MRecommendation.default(limit: 10)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameter limit: The maximum number of recommendations to retrieve. If not specified, the default value is used.
  /// - Returns: A collection of `MRecommendation` objects, each representing a recommendation
  /// item containing albums, playlists and/or stations.
  static func `default`(limit: Int? = nil) async throws -> MRecommendations {
    try await recommendations(limit)
  }

  /// Retrieve the default recommended playlists for a user.
  ///
  /// The recommendations are determined based
  /// on the user's past interactions and preferences.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let recommendations = try await MRecommendation.defaultPlaylists(limit: 10)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameter limit: The maximum number of recommended playlists to retrieve. If not specified, the default value is used.
  /// - Returns: A collection of `Playlist` objects.
  static func defaultPlaylists(limit: Int? = nil) async throws -> Playlists {
    let uniquePlaylists = try await recommendations(limit).reduce(into: Set<Playlist>()) { result, recommendation in
      recommendation.playlists.forEach { playlist in
        result.insert(playlist)
      }
    }

    return Playlists(Array(uniquePlaylists))
  }

  /// Retrieve the default recommended albums for a user.
  ///
  /// The recommendations are determined based
  /// on the user's past interactions and preferences.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let recommendations = try await MRecommendation.defaultAlbums(limit: 10)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameter limit: The maximum number of recommended albums to retrieve. If not specified, the default value is used.
  /// - Returns: A collection of `Album` objects.
  static func defaultAlbums(limit: Int? = nil) async throws -> Albums {
    let uniqueAlbums = try await recommendations(limit).reduce(into: Set<Album>()) { result, recommendation in
      recommendation.albums.forEach { album in
        result.insert(album)
      }
    }

    return Albums(Array(uniqueAlbums))
  }

  /// Retrieve the default recommended stations for a user.
  ///
  /// The recommendations are determined based
  /// on the user's past interactions and preferences.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let recommendations = try await MRecommendation.defaultStations(limit: 10)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameter limit: The maximum number of recommended stations to retrieve. If not specified, the default value is used.
  /// - Returns: A collection of unique `Station` objects.
  static func defaultStations(limit: Int? = nil) async throws -> Stations {
    let uniqueStations = try await recommendations(limit).reduce(into: Set<Station>()) { result, recommendation in
      recommendation.stations.forEach { station in
        result.insert(station)
      }
    }

    return Stations(Array(uniqueStations))
  }
}

extension MRecommendation {
  private static func recommendations(_ limit: Int? = nil) async throws -> MRecommendations {
    var request = MRecommendationRequest()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }
}
