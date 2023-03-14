//
//  MRecommendation+personal.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//



#if compiler(>=5.7)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public extension MRecommendation {

  /// Retrieve the default personal recommendations for a user.
  ///
  /// The recommendations are determined based
  /// on the user's past interactions and preferences.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let recommendations = try await MRecommendation.personal(limit: 10)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameter limit: The maximum number of recommended stations to retrieve. If not specified, the default value is used.
  /// - Returns: A collection of `MusicPersonalRecommendation` objects, each representing a recommendation
  /// item containing albums, playlists and/or stations.
  static func personal(limit: Int? = nil) async throws -> PersonalRecommendations {
    try await personalRecommendations(limit)
  }

  /// Retrieve the personal recommended albums for a user.
  ///
  /// The recommendations are determined based
  /// on the user's past interactions and preferences.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let recommendations = try await MRecommendation.personalAlbums(limit: 10)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameter limit: The maximum number of recommended albums to retrieve. If not specified, the default value is used.
  /// - Returns: A collection of `Album` objects.
  static func personalAlbums(limit: Int? = nil) async throws -> Albums {
    try await personalRecommendations(limit).reduce(into: Albums()) { $0 += $1.albums }
  }

  /// Retrieve the personal recommended stations for a user.
  ///
  /// The recommendations are determined based
  /// on the user's past interactions and preferences.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let recommendations = try await MRecommendation.personalStations(limit: 10)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameter limit: The maximum number of recommended stations to retrieve. If not specified, the default value is used.
  /// - Returns: A collection of `Station` objects.
  static func personalStations(limit: Int? = nil) async throws -> Stations {
    try await personalRecommendations(limit).reduce(into: Stations()) { $0 += $1.stations }
  }

  /// Retrieve the personal recommended playlists for a user.
  ///
  /// The recommendations are determined based
  /// on the user's past interactions and preferences.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let recommendations = try await MRecommendation.personalPlaylists(limit: 10)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameter limit: The maximum number of recommended playlists to retrieve. If not specified, the default value is used.
  /// - Returns: A collection of `Playlist` objects.
  static func personalPlaylists(limit: Int? = nil) async throws -> Playlists {
    try await personalRecommendations(limit).reduce(into: Playlists()) { $0 += $1.playlists }
  }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension MRecommendation {
  private static func personalRecommendations(_ limit: Int? = nil) async throws -> PersonalRecommendations {
    var request = MusicPersonalRecommendationsRequest()
    request.limit = limit
    let response = try await request.response()
    return response.recommendations
  }
}
#endif
