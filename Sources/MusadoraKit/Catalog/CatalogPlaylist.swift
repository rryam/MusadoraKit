//
//  CatalogPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

public extension MCatalog {
  /// Fetch a playlist from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  ///   - properties: Additional relationships to fetch with the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  static func playlist(id: MusicItemID, fetch properties: PlaylistProperties) async throws -> Playlist {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let playlist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return playlist
  }

  /// Fetch a playlist from the Apple Music catalog by using its identifier with all properties.
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  static func playlist(id: MusicItemID) async throws -> Playlist {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
    request.properties = .all
    let response = try await request.response()

    guard let playlist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return playlist
  }

  /// Fetch multiple playlists from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  ///   - properties: Additional relationships to fetch with the playlists.
  /// - Returns: `Playlists` matching the given identifiers.
  static func playlists(ids: [MusicItemID], fetch properties: PlaylistProperties) async throws -> Playlists {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple playlists from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  /// - Returns: `Playlists` matching the given identifiers.
  static func playlists(ids: [MusicItemID]) async throws -> Playlists {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return response.items
  }
}
