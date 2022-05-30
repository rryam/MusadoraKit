//
//  CatalogAlbum.swift
//  CatalogAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

/// A collection of albums.
public typealias Albums = MusicItemCollection<Album>

public extension MusadoraKit {
  /// Fetch an album from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  ///   - properties: Additional relationships to fetch with the album.
  /// - Returns: `Album` matching the given identifier.
  static func catalogAlbum(id: MusicItemID,
                           with properties: [PartialMusicAsyncProperty<Album>] = []) async throws -> Album
  {
    var request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let album = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return album
  }

  /// Fetch one or more albums from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the albums.
  ///   - properties: Additional relationships to fetch with the albums.
  /// - Returns: `Albums` matching the given identifiers.
  static func catalogAlbums(ids: [MusicItemID],
                            with properties: [PartialMusicAsyncProperty<Album>] = []) async throws -> Albums
  {
    var request = MusicCatalogResourceRequest<Album>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch an album from Apple Music catalog by using their UPC value.
  /// - Parameters:
  ///   - upc: The UPC (Universal Product Code) value for the album or single.
  ///   - properties: Additional relationships to fetch with the album.
  /// - Returns: `Album` matching the given UPC value.
  static func catalogAlbums(upc: String,
                            with properties: [PartialMusicAsyncProperty<Album>] = []) async throws -> Album
  {
    var request = MusicCatalogResourceRequest<Album>(matching: \.upc, equalTo: upc)
    request.properties = properties
    let response = try await request.response()

    guard let album = response.items.first else {
      throw MusadoraKitError.notFound(for: upc)
    }
    return album
  }

  /// Fetch multiple albums from Apple Music catalog by using their UPC values.
  /// - Parameters:
  ///   - upcs: The UPC (Universal Product Code) values for the albums or singles.
  ///   - properties: Additional relationships to fetch with the albums.
  /// - Returns: `Albums` matching the given UPC values.
  static func catalogAlbums(upcs: [String],
                            with properties: [PartialMusicAsyncProperty<Album>] = []) async throws -> Albums
  {
    var request = MusicCatalogResourceRequest<Album>(matching: \.upc, memberOf: upcs)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}
