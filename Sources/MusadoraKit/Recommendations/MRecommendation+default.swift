//
//  MRecommendation+default.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//

import MusicKit

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
    try await recommendations(limit).reduce(into: Playlists()) { $0 += $1.playlists }
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
    try await recommendations(limit).reduce(into: Albums()) { $0 += $1.albums }
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
  /// - Returns: A collection of `Station` objects.
  static func defaultStations(limit: Int? = nil) async throws -> Stations {
    try await recommendations(limit).reduce(into: Stations()) { $0 += $1.stations }
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
