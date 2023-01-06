//
//  CatalogArtist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/08/21.
//

import MusicKit

public extension MCatalog {
  /// Fetch an artist from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  ///   - properties: Additional relationships to fetch with the artist.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Artist` matching the given identifier.
  static func artist(with id: MusicItemID, with properties: ArtistProperties) async throws -> Artist {
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
  static func artist(with id: MusicItemID) async throws -> Artist {
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
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Artists` matching the given identifiers.
  static func artists(with ids: [MusicItemID], with properties: ArtistProperties) async throws -> Artists {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple artists from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the artists.
  /// - Returns: `Artists` matching the given identifiers.
  static func artists(with ids: [MusicItemID]) async throws -> Artists {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return response.items
  }
}
