//
//  LibrarySearch.swift
//  LibrarySearch
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

public enum MusicLibrarySearchType {
  case songs
  case albums
  case playlists
  case artists
  case musicVideos

#if compiler(>=5.7)
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  public var libraryType: MusicLibrarySearchable.Type {
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
#endif

  public var type: MusadoraLibrarySearchable.Type {
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

public extension MusadoraKit {
  /// Search the user's library by using a query.
  /// - Parameters:
  ///   - term: The text for the search
  ///   - types: The list of the types of resources to include in the results.
  ///   - limit: The number of objects returned. Default: 5, maximum Value: 25
  ///   - offset: The next page or group of objects to fetch.
  /// - Returns: `MusicLibrarySearchResponse` that contains results for a library search request.
  static func librarySearch(
    for term: String,
    types: [MusicLibrarySearchType],
    limit: Int? = nil,
    offset: Int? = nil) async throws -> MusadoraLibrarySearchResponse {
      let searchTypes = types.map { $0.type }
      var request = MusadoraLibrarySearchRequest(term: term, types: searchTypes)
      request.limit = limit
      request.offset = offset
      return try await request.response()
    }
}

#if compiler(>=5.7)
public extension MusadoraKit {
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func librarySearch(
    for term: String,
    types: [MusicLibrarySearchType],
    limit: Int = 5,
    offset: Int? = nil,
    includeTopResults: Bool = false) async throws -> MusicLibrarySearchResponse {
      let searchTypes = types.map { $0.libraryType }
      var request = MusicLibrarySearchRequest(term: term, types: searchTypes)
      request.limit = limit
      request.includeTopResults = includeTopResults
      return try await request.response()
    }
}
#endif
