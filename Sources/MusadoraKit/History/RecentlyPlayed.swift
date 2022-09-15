//
//  RecentlyPlayed.swift
//  RecentlyPlayed
//
//  Created by Rudrank Riyam on 25/08/22.
//

import Foundation
import MusicKit

#if compiler(>=5.7)
public extension MusadoraKit {
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  static func recentlyPlayed(limit: Int? = nil) async throws -> MusicItemCollection<RecentlyPlayedMusicItem> {
    var request = MusicRecentlyPlayedContainerRequest()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }
}
#endif

public extension MusadoraKit {
  /// Fetch the recently played resources for the user.
  /// - Parameter limit: The number of objects returned.
  /// - Returns: Collection of `UserMusicItem` that may be albums, playlists or stations.
  static func recentlyPlayed(limit: Int? = nil, offset: Int? = nil) async throws -> UserMusicItems {
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
  /// - Parameter limit: The number of objects returned.
  /// - Returns: Collection of `UserMusicItem` that may be albums, playlists or stations.
  static func recentlyAdded(limit: Int? = nil, offset: Int? = nil) async throws -> UserMusicItems {
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
