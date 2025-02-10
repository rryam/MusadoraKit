//
//  CatalogArtist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/08/21.
//

extension MCatalog {

  /// Fetch an artist from the Apple Music catalog by using its identifier.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  ///   - properties: Additional relationships to fetch with the artist.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Artist` matching the given identifier.
  public static func artist(id: MusicItemID, fetch properties: ArtistProperties) async throws
    -> Artist
  {
    try await artist(with: id, fetch: properties)
  }

  /// Fetch an artist from the Apple Music catalog by using its identifier.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  ///   - properties: Additional relationships to fetch with the artist.
  /// - Returns: `Artist` matching the given identifier.
  public static func artist(id: MusicItemID, fetch properties: ArtistProperty...) async throws
    -> Artist
  {
    try await artist(with: id, fetch: properties)
  }

  /// Fetch an artist from the Apple Music catalog by using its identifier.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  ///   - property: Additional property or relationship to fetch with the artist.
  /// - Returns: `Artist` matching the given identifier.
  public static func artist(id: MusicItemID, fetch property: ArtistProperty) async throws -> Artist
  {
    try await artist(with: id, fetch: [property])
  }

  /// Fetch an artist from the Apple Music catalog by using its identifier with all properties.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  /// - Returns: `Artist` matching the given identifier.
  public static func artist(id: MusicItemID) async throws -> Artist {
    try await artist(with: id, fetch: .all)
  }

  /// Fetch multiple artists from the Apple Music catalog by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the artists.
  ///   - properties: Additional relationships to fetch with the artists.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Artists` matching the given identifiers.
  public static func artists(ids: [MusicItemID], fetch properties: ArtistProperties) async throws
    -> Artists
  {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple artists from the Apple Music catalog by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the artists.
  ///   - property: Additional relationships to fetch with the artists.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `Artists` matching the given identifiers.
  public static func artists(ids: [MusicItemID], fetch property: ArtistProperty...) async throws
    -> Artists
  {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
    request.properties = property
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple artists from the Apple Music catalog by using their identifiers with all properties.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the artists.
  /// - Returns: `Artists` matching the given identifiers.
  public static func artists(ids: [MusicItemID]) async throws -> Artists {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return response.items
  }
}

extension MCatalog {
  static private func artist(with id: MusicItemID, fetch properties: ArtistProperties) async throws
    -> Artist
  {
    var request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: id)

    if !properties.isEmpty {
      request.properties = properties
    }

    let response = try await request.response()

    guard let artist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return artist
  }
}
