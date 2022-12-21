//
//  CatalogPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// Additional property/relationship of a playlist.
public typealias PlaylistProperty = PartialMusicAsyncProperty<Playlist>

/// Additional properties/relationships of a playlist.
public typealias PlaylistProperties = [PlaylistProperty]

public extension MusadoraKit {
  /// Fetch a playlist from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  ///   - properties: Additional relationships to fetch with the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  static func catalogPlaylist(id: MusicItemID, with properties: PlaylistProperties = []) async throws -> Playlist {
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
  static func catalogPlaylist(id: MusicItemID) async throws -> Playlist {
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
  static func catalogPlaylists(ids: [MusicItemID], with properties: PlaylistProperties = []) async throws -> Playlists {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple playlists from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  /// - Returns: `Playlists` matching the given identifiers.
  static func catalogPlaylists(ids: [MusicItemID]) async throws -> Playlists {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return response.items
  }
}

extension PlaylistProperties {
  public static var all: Self {
    var properties: Self = [.tracks, .featuredArtists, .moreByCurator]
#if compiler(>=5.7)
    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
      properties += [.curator, .radioShow]
      return properties
    } else {
      return properties
    }
#else
    return properties
#endif
  }
}
