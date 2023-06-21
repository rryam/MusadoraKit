//
//  LibrarySearch.swift
//  LibrarySearch
//
//  Created by Rudrank Riyam on 08/09/21.
//

@available(macOS 14.0, *)
public enum MLibrarySearchableType {
  case songs
  case albums
  case playlists
  case artists
  case musicVideos

#if compiler(>=5.7)
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, *)
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

  public var type: MLibrarySearchable.Type {
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
  /// - Returns: `MusicLibrarySearchResponse` that contains results for a library search request.
  static func search(
    for term: String,
    types: [MLibrarySearchableType],
    limit: Int? = nil,
    offset: Int? = nil) async throws -> MLibrarySearchResponse {
      let searchTypes = types.map { $0.type }
      var request = MLibrarySearchRequest(term: term, types: searchTypes)
      request.limit = limit
      request.offset = offset
      return try await request.response()
    }
}

#if compiler(>=5.7)
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, *)
public extension MLibrary {
  static func search(
    for term: String,
    types: [MLibrarySearchableType],
    limit: Int = 5,
    offset: Int? = nil,
    includeTopResults: Bool = false) async throws -> MusicLibrarySearchResponse {
      let searchTypes = types.map { $0.libraryType }
      var request = MusicLibrarySearchRequest(term: term, types: searchTypes)
      request.limit = limit
      request.includeTopResults = includeTopResults
      return try await request.response()
    }

  static func searchSongs(
    for term: String,
    limit: Int = 5,
    offset: Int? = nil,
    includeTopResults: Bool = false) async throws -> Songs {
      var request = MusicLibrarySearchRequest(term: term, types: [Song.self])
      request.limit = limit
      request.includeTopResults = includeTopResults
      let response = try await request.response()
      return response.songs
    }

  static func searchAlbums(
    for term: String,
    limit: Int = 5,
    offset: Int? = nil,
    includeTopResults: Bool = false) async throws -> Albums {
      var request = MusicLibrarySearchRequest(term: term, types: [Album.self])
      request.limit = limit
      request.includeTopResults = includeTopResults
      let response = try await request.response()
      return response.albums
    }

  static func searchPlaylists(
    for term: String,
    limit: Int = 5,
    offset: Int? = nil,
    includeTopResults: Bool = false) async throws -> Playlists {
      var request = MusicLibrarySearchRequest(term: term, types: [Playlist.self])
      request.limit = limit
      request.includeTopResults = includeTopResults
      let response = try await request.response()
      return response.playlists
    }

  static func searchMusicVideos(
    for term: String,
    limit: Int = 5,
    offset: Int? = nil,
    includeTopResults: Bool = false) async throws -> MusicVideos {
      var request = MusicLibrarySearchRequest(term: term, types: [MusicVideo.self])
      request.limit = limit
      request.includeTopResults = includeTopResults
      let response = try await request.response()
      return response.musicVideos
    }

  static func searchArtists(
    for term: String,
    limit: Int = 5,
    offset: Int? = nil,
    includeTopResults: Bool = false) async throws -> Artists {
      var request = MusicLibrarySearchRequest(term: term, types: [Artist.self])
      request.limit = limit
      request.includeTopResults = includeTopResults
      let response = try await request.response()
      return response.artists
    }
}
#endif
