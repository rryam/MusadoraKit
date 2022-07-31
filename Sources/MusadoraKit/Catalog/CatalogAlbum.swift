//
//  CatalogAlbum.swift
//  CatalogAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

/// A collection of albums.
public typealias Albums = MusicItemCollection<Album>

/// Additional property/relationship of an album.
public typealias AlbumProperty = PartialMusicAsyncProperty<Album>

/// Additional properties/relationships of an album.
public typealias AlbumProperties = [AlbumProperty]

public extension MusadoraKit {
  /// Fetch an album from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  ///   - properties: Additional relationships to fetch with the album.
  /// - Returns: `Album` matching the given identifier.
  static func catalogAlbum(id: MusicItemID, with properties: AlbumProperties = []) async throws -> Album {
    try await fetchCatalogAlbum(id: id, with: properties)
  }

  /// Fetch an album from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  ///   - properties: Additional relationships to fetch with the album.
  /// - Returns: `Album` matching the given identifier.
  static func catalogAlbum(id: MusicItemID, with properties: AlbumProperty...) async throws -> Album {
    try await fetchCatalogAlbum(id: id, with: properties)
  }

  /// Fetch an album from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  ///   - property: Additional property or relationship to fetch with the album.
  /// - Returns: `Album` matching the given identifier.
  static func catalogAlbum(id: MusicItemID, with property: AlbumProperty) async throws -> Album {
    try await fetchCatalogAlbum(id: id, with: [property])
  }
  
  /// Fetch an album from the Apple Music catalog by using its identifier with all properties.
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  /// - Returns: `Album` matching the given identifier.
  static func catalogAlbum(id: MusicItemID) async throws -> Album {
    try await fetchCatalogAlbum(id: id, with: .all)
  }
  
  /// Fetch one or more albums from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the albums.
  ///   - properties: Additional relationships to fetch with the albums.
  /// - Returns: `Albums` matching the given identifiers.
  static func catalogAlbums(ids: [MusicItemID], with properties: AlbumProperties = []) async throws -> Albums {
    try await fetchCatalogAlbums(ids: ids, with: properties)
  }
  
  /// Fetch one or more albums from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the albums.
  /// - Returns: `Albums` matching the given identifiers.
  static func catalogAlbums(ids: [MusicItemID]) async throws -> Albums {
    try await fetchCatalogAlbums(ids: ids, with: .all)
  }
  
  /// Fetch an album from Apple Music catalog by using their UPC value.
  /// - Parameters:
  ///   - upc: The UPC (Universal Product Code) value for the album or single.
  ///   - properties: Additional relationships to fetch with the album.
  /// - Returns: `Album` matching the given UPC value.
  static func catalogAlbums(upc: String, with properties: AlbumProperties = []) async throws -> Album {
    try await fetchCatalogAlbums(upc: upc, with: properties)
  }
  
  /// Fetch an album from Apple Music catalog by using their UPC value with all properties.
  /// - Parameters:
  ///   - upc: The UPC (Universal Product Code) value for the album or single.
  /// - Returns: `Album` matching the given UPC value.
  static func catalogAlbums(upc: String) async throws -> Album {
    try await fetchCatalogAlbums(upc: upc, with: .all)
  }
  
  /// Fetch multiple albums from Apple Music catalog by using their UPC values.
  /// - Parameters:
  ///   - upcs: The UPC (Universal Product Code) values for the albums or singles.
  ///   - properties: Additional relationships to fetch with the albums.
  /// - Returns: `Albums` matching the given UPC values.
  static func catalogAlbums(upcs: [String], with properties: AlbumProperties = []) async throws -> Albums {
    try await fetchCatalogAlbums(upcs: upcs, with: properties)
  }
  
  /// Fetch multiple albums from Apple Music catalog by using their UPC values with all properties.
  /// - Parameters:
  ///   - upcs: The UPC (Universal Product Code) values for the albums or singles.
  /// - Returns: `Albums` matching the given UPC values.
  static func catalogAlbums(upcs: [String]) async throws -> Albums {
    try await fetchCatalogAlbums(upcs: upcs, with: .all)
  }
}

extension MusadoraKit {
  static private func fetchCatalogAlbum(id: MusicItemID, with properties: AlbumProperties) async throws -> Album {
    var request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let album = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return album
  }

  static private func fetchCatalogAlbums(ids: [MusicItemID], with properties: AlbumProperties) async throws -> Albums {
    var request = MusicCatalogResourceRequest<Album>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  static private func fetchCatalogAlbums(upc: String, with properties: AlbumProperties) async throws -> Album {
    var request = MusicCatalogResourceRequest<Album>(matching: \.upc, equalTo: upc)
    request.properties = properties
    let response = try await request.response()

    guard let album = response.items.first else {
      throw MusadoraKitError.notFound(for: upc)
    }
    return album
  }

  static private func fetchCatalogAlbums(upcs: [String], with properties: AlbumProperties) async throws -> Albums {
    var request = MusicCatalogResourceRequest<Album>(matching: \.upc, memberOf: upcs)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}

extension Array where Element == AlbumProperty {
  public static var all: Self {
    var properties: AlbumProperties = [.artistURL, .genres, .artists, .appearsOn, .otherVersions, .recordLabels, .relatedAlbums, .relatedVideos, .tracks]
#if compiler(>=5.7)
    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
      properties += [.audioVariants]
      return properties
    } else {
      return properties
    }
#else
    return properties
#endif
  }
}
