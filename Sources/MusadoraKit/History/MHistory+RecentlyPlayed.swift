// 
//  RecentlyPlayed.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/08/22.
//

import Foundation

public extension MHistory {
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  static func recentlyPlayed(limit: Int? = nil) async throws -> MusicItemCollection<
    RecentlyPlayedMusicItem
  > {
    var request = MusicRecentlyPlayedContainerRequest()
    request.limit = limit
    let response = try await request.response()
    return try await response.items.collectingAll(upTo: limit)
  }

  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  static func recentlyPlayedSongs(limit: Int? = nil) async throws -> Songs {
    var request = MusicRecentlyPlayedRequest<Song>()
    request.limit = limit
    let response = try await request.response()
    return try await response.items.collectingAll(upTo: limit)
  }

  ///  The @available attribute indicates that the `mostPlayedSongs(limit:)` function is available on iOS 16.0 and later, macOS 13.0 and later, tvOS 16.0 and later, and watchOS 9.0 and later.
  ///
  ///  Use this function to retrieve a list of the most played songs from the user's music library. The limit parameter specifies the maximum number of songs to return. The default value is 100. The songs are sorted by the number of times they have been played, in descending order.
  ///
  ///  This function is asynchronous. If the request is successful, it returns a list of `Song` objects. If an error occurs, the function throws an exception.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let songs = try await mostPlayedSongs(limit: 200)
  ///    /// Use the list of songs.
  ///  } catch {
  ///    /// Handle the error.
  ///  }
  ///  ```
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *, macOS 14.0, macCatalyst 17.0, *)
  static func mostPlayedSongs(limit: Int = 100) async throws -> Songs {
    var request = MusicLibraryRequest<Song>()
    request.limit = limit
    request.sort(by: \.playCount, ascending: false)
    let response = try await request.response()
    return try await response.items.collectingAll(upTo: limit)
  }
}

public extension MHistory {
  /// Fetch the recently played resources for the user.
  /// - Parameters:
  ///   - limit: The number of objects returned.
  ///   - offset: The offset for pagination.
  /// - Returns: Collection of `UserMusicItem` that may be albums, playlists or stations.
  static func recentlyPlayed(limit: Int? = nil, offset: Int? = nil) async throws
    -> UserMusicItems {
    var request = MusicHistoryRequest(for: .recentlyPlayed)
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.items
  }

  /// Fetch the recently played albums for the user.
  /// - Parameter limit: The number of objects returned.
  /// - Returns: A collection of albums.
  static func recentlyPlayedAlbums(limit: Int? = nil) async throws -> Albums {
    var request = MusicHistoryRequest(for: .recentlyPlayed)
    request.limit = limit
    let response = try await request.response()
    return response.albums
  }

  /// Fetch the recently played playlists for the user.
  /// - Parameter limit: The number of objects returned.
  /// - Returns: A collection of albums.
  static func recentlyPlayedPlaylists(limit: Int? = nil) async throws -> Playlists {
    var request = MusicHistoryRequest(for: .recentlyPlayed)
    request.limit = limit
    let response = try await request.response()
    return response.playlists
  }

  /// Fetch the resources in heavy rotation for the user.
  /// - Parameter limit: The number of objects returned.
  /// - Returns: Collection of `UserMusicItem` that may be albums, playlists or stations.
  static func heavyRotation(limit: Int? = nil) async throws -> UserMusicItems {
    var request = MusicHistoryRequest(for: .heavyRotation)
    request.limit = limit
    let response = try await request.response()
    return response.items
  }

  /// Fetch the recently added resources for the user.
  /// - Parameters:
  ///   - limit: The number of objects returned.
  ///   - offset: The offset for pagination.
  /// - Returns: Collection of `UserMusicItem` that may be albums, playlists or stations.
  static func recentlyAdded(limit: Int? = nil, offset: Int? = nil) async throws
    -> UserMusicItems {
    var request = MusicHistoryRequest(for: .recentlyAdded)
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.items
  }

  /// Fetch the recently played tracks for the user.
  /// - Parameter limit: The number of objects returned.
  /// - Returns: Collection of `Tracks`.
  static func recentlyPlayedTracks(limit: Int? = nil) async throws -> Tracks {
    var request = MusicHistoryRequest(for: .recentlyPlayedTracks)
    request.limit = limit
    let response = try await request.response()
    return response.tracks
  }

  /// Fetch the recently played stations for the user.
  /// - Parameter limit: The number of objects returned.
  /// - Returns: Collection of `Stations`.
  static func recentlyPlayedStations(limit: Int? = nil) async throws -> Stations {
    var request = MusicHistoryRequest(for: .recentlyPlayedStations)
    request.limit = limit
    let response = try await request.response()
    return response.stations
  }
}
