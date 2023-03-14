//
//  CatalogAlbum.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 14/08/21.
//



public extension MCatalog {
  /// Fetch an album from the Apple Music catalog by using its identifier.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  ///   - properties: Additional relationships to fetch with the album.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Album` matching the given identifier.
  static func album(id: MusicItemID, fetch properties: AlbumProperties) async throws -> Album {
    try await album(with: id, fetch: properties)
  }

  /// Fetch an album from the Apple Music catalog by using its identifier.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  ///   - properties: Additional relationships to fetch with the album.
  /// - Returns: `Album` matching the given identifier.
  static func album(id: MusicItemID, fetch properties: AlbumProperty...) async throws -> Album {
    try await album(with: id, fetch: properties)
  }

  /// Fetch an album from the Apple Music catalog by using its identifier.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  ///   - property: Additional property or relationship to fetch with the album.
  /// - Returns: `Album` matching the given identifier.
  static func album(id: MusicItemID, fetch property: AlbumProperty) async throws -> Album {
    try await album(with: id, fetch: [property])
  }
  
  /// Fetch an album from the Apple Music catalog by using its identifier with all properties.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  /// - Returns: `Album` matching the given identifier.
  static func album(id: MusicItemID) async throws -> Album {
    try await album(with: id, fetch: .all)
  }
  
  /// Fetch one or more albums from the Apple Music catalog by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the albums.
  ///   - properties: Additional relationships to fetch with the albums.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Albums` matching the given identifiers.
  static func albums(ids: [MusicItemID], fetch properties: AlbumProperties) async throws -> Albums {
    try await albums(with: ids, fetch: properties)
  }
  
  /// Fetch one or more albums from the Apple Music catalog by using their identifiers with all properties.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the albums.
  /// - Returns: `Albums` matching the given identifiers.
  static func albums(ids: [MusicItemID]) async throws -> Albums {
    try await albums(with: ids, fetch: .all)
  }
  
  /// Fetch an album from Apple Music catalog by using their UPC value.
  ///
  /// - Parameters:
  ///   - upc: The UPC (Universal Product Code) value for the album or single.
  ///   - properties: Additional relationships to fetch with the album.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Album` matching the given UPC value.
  static func albums(upc: String, fetch properties: AlbumProperties) async throws -> Album {
    try await albums(for: upc, fetch: properties)
  }
  
  /// Fetch an album from Apple Music catalog by using their UPC value with all properties.
  ///
  /// - Parameters:
  ///   - upc: The UPC (Universal Product Code) value for the album or single.
  /// - Returns: `Album` matching the given UPC value.
  static func albums(upc: String) async throws -> Album {
    try await albums(for: upc, fetch: .all)
  }
  
  /// Fetch multiple albums from Apple Music catalog by using their UPC values.
  ///
  /// - Parameters:
  ///   - upcs: The UPC (Universal Product Code) values for the albums or singles.
  ///   - properties: Additional relationships to fetch with the albums.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Albums` matching the given UPC values.
  static func albums(upcs: [String], fetch properties: AlbumProperties) async throws -> Albums {
    try await albums(for: upcs, fetch: properties)
  }
  
  /// Fetch multiple albums from Apple Music catalog by using their UPC values with all properties.
  ///
  /// - Parameters:
  ///   - upcs: The UPC (Universal Product Code) values for the albums or singles.
  /// - Returns: `Albums` matching the given UPC values.
  static func albums(upcs: [String]) async throws -> Albums {
    try await albums(for: upcs, fetch: .all)
  }
}

extension MCatalog {
  static private func album(with id: MusicItemID, fetch properties: AlbumProperties) async throws -> Album {
    var request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let album = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return album
  }

  static private func albums(with ids: [MusicItemID], fetch properties: AlbumProperties) async throws -> Albums {
    var request = MusicCatalogResourceRequest<Album>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  static private func albums(for upc: String, fetch properties: AlbumProperties) async throws -> Album {
    var request = MusicCatalogResourceRequest<Album>(matching: \.upc, equalTo: upc)
    request.properties = properties
    let response = try await request.response()

    guard let album = response.items.first else {
      throw MusadoraKitError.notFound(for: upc)
    }
    return album
  }

  static private func albums(for upcs: [String], fetch properties: AlbumProperties) async throws -> Albums {
    var request = MusicCatalogResourceRequest<Album>(matching: \.upc, memberOf: upcs)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}
