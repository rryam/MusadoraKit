//
//  CatalogArtist.swift
//  CatalogArtist
//
//  Created by Rudrank Riyam on 25/08/21.
//

import MusicKit

/// A collection of artists.
public typealias Artists = MusicItemCollection<Artist>

/// Additional property/relationship of an artist.
public typealias ArtistProperty = PartialMusicAsyncProperty<Artist>

/// Additional properties/relationships of an artist.
public typealias ArtistProperties = [ArtistProperty]

public extension MusadoraKit {
  /// Fetch an artist from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  ///   - properties: Additional relationships to fetch with the artist.
  /// - Returns: `Artist` matching the given identifier.
  static func catalogArtist(id: MusicItemID, with properties: ArtistProperties = []) async throws -> Artist {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let artist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return artist
  }

  /// Fetch an artist from the Apple Music catalog by using its identifier with all properties.
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  /// - Returns: `Artist` matching the given identifier.
  static func catalogArtist(id: MusicItemID) async throws -> Artist {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: id)
    request.properties = .all
    let response = try await request.response()

    guard let artist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return artist
  }

  /// Fetch multiple artists from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the artists.
  ///   - properties: Additional relationships to fetch with the artists.
  /// - Returns: `Artists` matching the given identifiers.
  static func catalogArtists(ids: [MusicItemID], with properties: ArtistProperties = []) async throws -> Artists {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple artists from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the artists.
  /// - Returns: `Artists` matching the given identifiers.
  static func catalogArtists(ids: [MusicItemID]) async throws -> Artists {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return response.items
  }
}

extension Array where Element == ArtistProperty {
  public static var all: Self {
    [.genres, .station, .musicVideos, .albums, .playlists, .appearsOnAlbums, .fullAlbums, .featuredAlbums, .liveAlbums, .compilationAlbums, .featuredPlaylists, .latestRelease, .topSongs, .topMusicVideos, .similarArtists, .singles]
  }
}
