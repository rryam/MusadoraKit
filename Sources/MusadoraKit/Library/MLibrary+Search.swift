// 
//  LibrarySearch.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

/// An enumeration representing different types of items that can be searched within the Apple Music library.
///
/// `MusicLibrarySearchableItemType` provides you with a way to specify the kind of music item you want to search for.
/// For instance, whether you are interested in songs, albums, artists, etc.
///
/// Use this enumeration when performing search operations on the user's music library,
/// especially when you need to specify the type of items you are searching for.
///
/// **Usage Example**:
///
///     let searchType = MusicLibrarySearchableItemType.songs
///     let results = myLibrary.search(for: "Imagine", ofType: searchType)
///
@available(macOS 14.0, *)
public enum MusicLibrarySearchableItemType {
  /// Represents individual song tracks.
  case songs

  /// Represents music album collections.
  case albums

  /// Represents user-defined or preset playlists.
  case playlists

  /// Represents individual music artists.
  case artists

  /// Represents music videos.
  case musicVideos

  /// Provides the associated `MusicLibrarySearchableItem` type for the current enumeration case.
  ///
  /// This is particularly useful when working with the newer Apple Music SDK, which
  ///  might expect types conforming to the `MusicLibrarySearchableItem` protocol.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
  public var libraryType: MusicLibrarySearchableItem.Type {
    switch self {
    case .songs:
      return Song.self
    case .albums:
      return Album.self
    case .playlists:
      return Playlist.self
    case .artists:
      return Artist.self
    case .musicVideos:
      return MusicVideo.self
    }
  }

  /// Provides the associated `MusicLibrarySearchableItem` type for the current enumeration case.
  ///
  /// This is useful when working with functionalities that require a type conforming to the `MusicLibrarySearchableItem` protocol.
  public var type: MusicLibrarySearchableItem.Type {
    switch self {
    case .songs:
      return Song.self
    case .albums:
      return Album.self
    case .playlists:
      return Playlist.self
    case .artists:
      return Artist.self
    case .musicVideos:
      return MusicVideo.self
    }
  }
}

@available(macOS 14.0, *)
public extension MLibrary {
  /// Search the user's library by using a query.
  /// - Parameters:
  ///   - term: The text for the search
  ///   - types: The list of the types of resources to include in the results.
  ///   - limit: The number of objects returned. Default: 5, maximum Value: 25
  ///   - offset: The next page or group of objects to fetch.
  /// - Returns: `MusicSearchLibraryResponse` that contains results for a library search request.
  static func search(
    for term: String,
    types: [MusicLibrarySearchableItemType],
    limit: Int? = nil,
    offset: Int? = nil) async throws -> MusicSearchLibraryResponse {
      let searchTypes = types.map { $0.type }
      var request = MusicSearchLibraryRequest(term: term, types: searchTypes)
      request.limit = limit
      request.offset = offset
      return try await request.response()
    }
}

// MARK: - Generic Search Helper
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
private extension MLibrary {
    private static func search<ResponseType, ItemType: MusicLibrarySearchableItem>(
        for term: String,
        itemType: ItemType.Type,
        keyPath: KeyPath<MusicSearchLibraryResponse, ResponseType>,
        limit: Int,
        includeTopResults: Bool
    ) async throws -> ResponseType {
        var request = MusicSearchLibraryRequest(term: term, types: [itemType])
        request.limit = limit
        request.includeTopResults = includeTopResults
        let response = try await request.response()
        return response[keyPath: keyPath]
    }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
public extension MLibrary {
  static func search(
    for term: String,
    types: [MusicLibrarySearchableItemType],
    limit: Int = 5,
    offset: Int? = nil,
    includeTopResults: Bool = false) async throws -> MusicSearchLibraryResponse {
      let searchTypes = types.map { $0.libraryType }
      var request = MusicSearchLibraryRequest(term: term, types: searchTypes)
      request.limit = limit
      request.includeTopResults = includeTopResults
      return try await request.response()
    }

  static func searchSongs(
    for term: String,
    limit: Int = 5,
    includeTopResults: Bool = false) async throws -> Songs {
      try await search(for: term, itemType: Song.self, keyPath: \.songs, limit: limit, includeTopResults: includeTopResults)
    }

  static func searchAlbums(
    for term: String,
    limit: Int = 5,
    includeTopResults: Bool = false) async throws -> Albums {
      try await search(for: term, itemType: Album.self, keyPath: \.albums, limit: limit, includeTopResults: includeTopResults)
    }

  static func searchPlaylists(
    for term: String,
    limit: Int = 5,
    includeTopResults: Bool = false) async throws -> Playlists {
      try await search(for: term, itemType: Playlist.self, keyPath: \.playlists, limit: limit, includeTopResults: includeTopResults)
    }

  static func searchMusicVideos(
    for term: String,
    limit: Int = 5,
    includeTopResults: Bool = false) async throws -> MusicVideos {
      try await search(for: term, itemType: MusicVideo.self, keyPath: \.musicVideos, limit: limit, includeTopResults: includeTopResults)
    }

  static func searchArtists(
    for term: String,
    limit: Int = 5,
    includeTopResults: Bool = false) async throws -> Artists {
      try await search(for: term, itemType: Artist.self, keyPath: \.artists, limit: limit, includeTopResults: includeTopResults)
    }
}
