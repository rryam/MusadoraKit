//
//  CatalogSong.swift
//  CatalogSong
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

/// A collection of songs.
public typealias Songs = MusicItemCollection<Song>

/// Additional property/relationship of a song.
public typealias SongProperty = PartialMusicAsyncProperty<Song>

/// Additional properties/relationships of a song.
public typealias SongProperties = [PartialMusicAsyncProperty<Song>]

public extension MusadoraKit {

  /// Fetch a song from the Apple Music catalog by using its identifier.
  ///
  /// In the following example, the method fetched the details of the song **Me, Myself & I** by G-Eazy
  /// with the ID `1544326470` without any additional properties, nor relationships:
  ///
  ///     let id: MusicItemID = "1544326470"
  ///     let song = try await MusadoraKit.catalogSong(id: id)
  ///
  /// To fetch additional relationships like `albums` or properties like `artistURL` in the same request,
  /// specify them in the `with` parameter:
  ///
  ///     let id: MusicItemID = "1544326470"
  ///     let song = try await MusadoraKit.catalogSong(id: id, with: [.albums, .artistURL])
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  ///   - properties: Additional relationships to fetch with the song.
  /// - Returns: `Song` matching the given identifier.
  static func catalogSong(id: MusicItemID, with properties: SongProperties = []) async throws -> Song {
    try await fetchCatalogSong(id: id, with: properties)
  }

  /// Fetch a song from the Apple Music catalog by using its identifier.
  ///
  /// In the following example, the method fetched the details of the song **bad guy** by Billie Eilish
  /// with the ID `1544326470` with a single relationship `artists`:
  ///
  ///     let id: MusicItemID = "1450695739"
  ///     let song = try await MusadoraKit.catalogSong(id: id, with .artists)
  ///
  /// To fetch additional relationships like `genres` or properties like `artistURL` in the same request,
  /// specify them in the `with` parameter:
  ///
  ///     let id: MusicItemID = "1450695739"
  ///     let song = try await MusadoraKit.catalogSong(id: id, with: .genres, .artistURL)
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  ///   - properties: Additional relationships to fetch with the song.
  /// - Returns: `Song` matching the given identifier.
  ///
  /// - Note: It is a personal preference to either use the method where the `with` parameter takes an array of
  ///  `SongProperty` or as a variadic parameter.
  static func catalogSong(id: MusicItemID, with properties: SongProperty...) async throws -> Song {
    try await fetchCatalogSong(id: id, with: properties)
  }

  /// Fetch a song from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  ///   - property: Additional property or relationship to fetch with the song.
  /// - Returns: `Song` matching the given identifier.
  static func catalogSong(id: MusicItemID, with property: SongProperty) async throws -> Song {
    try await fetchCatalogSong(id: id, with: [property])
  }

  /// Fetch a song from the Apple Music catalog by using its identifier with all properties.
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  /// - Returns: `Song` matching the given identifier.
  static func catalogSong(id: MusicItemID) async throws -> Song {
    try await fetchCatalogSong(id: id, with: .all)
  }

  /// Fetch multiple songs from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func catalogSongs(ids: [MusicItemID], with properties: SongProperties = []) async throws -> Songs {
    try await fetchCatalogSongs(ids: ids, with: properties)
  }

  /// Fetch multiple songs from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func catalogSongs(ids: [MusicItemID], with properties: SongProperty...) async throws -> Songs {
    try await fetchCatalogSongs(ids: ids, with: properties)
  }

  /// Fetch multiple songs from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  ///   - property: Additional property or relationship to fetch with the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func catalogSongs(ids: [MusicItemID], with property: SongProperty) async throws -> Songs {
    try await fetchCatalogSongs(ids: ids, with: [property])
  }

  /// Fetch multiple songs from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func catalogSongs(ids: [MusicItemID]) async throws -> Songs {
    try await fetchCatalogSongs(ids: ids, with: .all)
  }

  /// Fetch one or more songs from Apple Music catalog by using their ISRC value.
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC value.
  /// - Note: One ISRC value may return more than one song.
  static func catalogSong(isrc: String, with properties: SongProperties = []) async throws -> Songs {
    try await fetchCatalogSong(isrc: isrc, with: properties)
  }

  /// Fetch one or more songs from Apple Music catalog by using their ISRC value.
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC value.
  /// - Note: One ISRC value may return more than one song.
  static func catalogSong(isrc: String, with properties: SongProperty...) async throws -> Songs {
    try await fetchCatalogSong(isrc: isrc, with: properties)
  }

  /// Fetch one or more songs from Apple Music catalog by using their ISRC value.
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - property: Additional property or relationship to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC value.
  /// - Note: One ISRC value may return more than one song.
  static func catalogSong(isrc: String, with property: SongProperty) async throws -> Songs {
    try await fetchCatalogSong(isrc: isrc, with: [property])
  }

  /// Fetch one or more songs from Apple Music catalog by using their ISRC value with all properties.
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  /// - Returns: `Songs` matching the given ISRC value.
  /// - Note: One ISRC value may return more than one song.
  static func catalogSong(isrc: String) async throws -> Songs {
    try await fetchCatalogSong(isrc: isrc, with: .all)
  }

  /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC values.
  /// - Note: One ISRC value may return more than one song.
  static func catalogSongs(isrc: [String], with properties: SongProperties = []) async throws -> Songs {
    try await fetchCatalogSongs(isrc: isrc, with: properties)
  }

  /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - properties: Additional relationships to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC values.
  /// - Note: One ISRC value may return more than one song.
  static func catalogSongs(isrc: [String], with properties: SongProperty...) async throws -> Songs {
    try await fetchCatalogSongs(isrc: isrc, with: properties)
  }

  /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  ///   - property: Additional property or relationship to fetch with the songs.
  /// - Returns: `Songs` matching the given ISRC values.
  /// - Note: One ISRC value may return more than one song.
  static func catalogSongs(isrc: [String], with property: SongProperty) async throws -> Songs {
    try await fetchCatalogSongs(isrc: isrc, with: [property])
  }

  /// Fetch multiple songs from Apple Music catalog by using their ISRC values with all properties.
  ///
  /// Note that one ISRC value may return more than one song.
  /// - Parameters:
  ///   - isrc: The ISRC values for the songs.
  /// - Returns: `Songs` matching the given ISRC values.
  static func catalogSongs(isrc: [String]) async throws -> Songs {
    try await fetchCatalogSongs(isrc: isrc, with: .all)
  }
}

extension MusadoraKit {
  static private func fetchCatalogSong(id: MusicItemID, with properties: SongProperties) async throws -> Song {
    var request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let song = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return song
  }

  static private func fetchCatalogSongs(ids: [MusicItemID], with properties: SongProperties) async throws -> Songs {
    var request = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  static private func fetchCatalogSong(isrc: String, with properties: SongProperties) async throws -> Songs {
    var request = MusicCatalogResourceRequest<Song>(matching: \.isrc, equalTo: isrc)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  static private func fetchCatalogSongs(isrc: [String], with properties: SongProperties) async throws -> Songs {
    var request = MusicCatalogResourceRequest<Song>(matching: \.isrc, memberOf: isrc)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}

extension Array where Element == SongProperty {
  public static var all: Self {
    var properties: SongProperties = [.albums, .artists, .composers, .genres, .musicVideos, .artistURL, .station]
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
