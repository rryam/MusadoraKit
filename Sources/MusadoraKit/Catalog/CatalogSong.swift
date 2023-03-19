//
//  CatalogSong.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 14/08/21.
//

public extension MCatalog {

  /// Fetch a song from the Apple Music catalog by using its identifier.
  ///
  /// In the following example, the method fetches the details of the song **Me, Myself & I** by G-Eazy
  /// with the ID `1544326470`.
  /// It also fetches additional relationships like `albums` or properties like `artistURL` in the
  /// same request, by specifying them in the `fetch` parameter:
  ///
  ///     let id: MusicItemID = "1544326470"
  ///     let song = try await MCatalog.song(id: id, fetch: [.albums, .artistURL])
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  ///   - properties: Additional relationships and properties to fetch with the song.
  /// - Returns: `Song` matching the given identifier.
  static func song(id: MusicItemID, fetch properties: SongProperties) async throws -> Song {
    try await song(id: id, properties: properties)
  }

  /// Fetch a song from the Apple Music catalog by using its identifier.
  ///
  /// In the following example, the method fetches the details of the song **bad guy** by Billie Eilish
  /// with the ID `1544326470` with a single relationship `artists`:
  ///
  ///     let id: MusicItemID = "1450695739"
  ///     let song = try await MCatalog.song(id: id, fetch: .artists)
  ///
  /// To fetch additional relationships like `genres` or properties like `artistURL` in the same request,
  /// specify them in the `fetch` parameter:
  ///
  ///     let id: MusicItemID = "1450695739"
  ///     let song = try await MCatalog.song(id: id, fetch: .genres, .artistURL)
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  ///   - properties: Additional relationships to fetch with the song.
  /// - Returns: `Song` matching the given identifier.
  ///
  /// - Note: It is a personal preference to either use the method where the `fetch` parameter takes an array of
  ///  `SongProperty` or as a variadic parameter.
  static func song(id: MusicItemID, fetch properties: SongProperty...) async throws -> Song {
    try await song(id: id, properties: properties)
  }

  /// Fetch a song from the Apple Music catalog by using its identifier.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  ///   - property: Additional property or relationship to fetch with the song.
  /// - Returns: `Song` matching the given identifier.
  static func song(id: MusicItemID, fetch property: SongProperty) async throws -> Song {
    try await song(id: id, properties: [property])
  }

  /// Fetch a song from the Apple Music catalog by using its identifier with no properties.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  /// - Returns: `Song` matching the given identifier.
  static func song(id: MusicItemID) async throws -> Song {
    try await song(id: id, properties: [])
  }

  /// Fetch multiple songs from the Apple Music catalog by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func songs(ids: [MusicItemID], fetch properties: SongProperties) async throws -> Songs {
    try await songs(ids: ids, properties: properties)
  }

  /// Fetch multiple songs from the Apple Music catalog by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func songs(ids: [MusicItemID], fetch properties: SongProperty...) async throws -> Songs {
    try await songs(ids: ids, properties: properties)
  }

  /// Fetch multiple songs from the Apple Music catalog by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  ///   - property: Additional property or relationship to fetch with the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func songs(ids: [MusicItemID], fetch property: SongProperty) async throws -> Songs {
    try await songs(ids: ids, properties: [property])
  }

  /// Fetch multiple songs from the Apple Music catalog by using their identifiers with no properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func songs(ids: [MusicItemID]) async throws -> Songs {
    try await songs(ids: ids, properties: [])
  }

  /// Fetch one or more songs from Apple Music catalog by using their ISRC value.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC value.
  ///
  /// - Note: One ISRC value may return more than one song.
  static func song(isrc: String, fetch properties: SongProperties) async throws -> Songs {
    try await song(isrc: isrc, properties: properties)
  }

  /// Fetch one or more songs from Apple Music catalog by using their ISRC value.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC value.
  ///
  /// - Note: One ISRC value may return more than one song.
  static func song(isrc: String, fetch properties: SongProperty...) async throws -> Songs {
    try await song(isrc: isrc, properties: properties)
  }

  /// Fetch one or more songs from Apple Music catalog by using their ISRC value.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - property: Additional property or relationship to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC value.
  ///
  /// - Note: One ISRC value may return more than one song.
  static func song(isrc: String, fetch property: SongProperty) async throws -> Songs {
    try await song(isrc: isrc, properties: [property])
  }

  /// Fetch one or more songs from Apple Music catalog by using their ISRC value with no properties.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  /// - Returns: `Songs` matching the given ISRC value.
  ///
  /// - Note: One ISRC value may return more than one song.
  static func song(isrc: String) async throws -> Songs {
    try await song(isrc: isrc, properties: [])
  }

  /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC values.
  ///
  /// - Note: One ISRC value may return more than one song.
  static func songs(isrc: [String], fetch properties: SongProperties) async throws -> Songs {
    try await songs(isrc: isrc, properties: properties)
  }

  /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC values.
  ///
  /// - Note: One ISRC value may return more than one song.
  static func songs(isrc: [String], fetch properties: SongProperty...) async throws -> Songs {
    try await songs(isrc: isrc, properties: properties)
  }

  /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - property: Additional property or relationship to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC values.
  ///
  static func songs(isrc: [String], fetch property: SongProperty) async throws -> Songs {
    try await songs(isrc: isrc, properties: [property])
  }

  /// Fetch multiple songs from Apple Music catalog by using their ISRC values with no properties.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  /// - Returns: `Songs` matching the given ISRC values.
  ///
  /// - Note: One ISRC value may return more than one song.
  static func songs(isrc: [String]) async throws -> Songs {
    try await songs(isrc: isrc, properties: [])
  }
}

extension MCatalog {
  static private func song(id: MusicItemID, properties: SongProperties) async throws -> Song {
    var request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let song = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return song
  }

  static private func songs(ids: [MusicItemID], properties: SongProperties) async throws -> Songs {
    var request = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  static private func song(isrc: String, properties: SongProperties) async throws -> Songs {
    var request = MusicCatalogResourceRequest<Song>(matching: \.isrc, equalTo: isrc)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  static private func songs(isrc: [String], properties: SongProperties) async throws -> Songs {
    var request = MusicCatalogResourceRequest<Song>(matching: \.isrc, memberOf: isrc)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}
