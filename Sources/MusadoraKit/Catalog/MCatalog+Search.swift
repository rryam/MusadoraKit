// 
//  CatalogSearch.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 20/08/21.
//

public extension MCatalog {
  /// Search the Apple Music catalog by using a query term.
  ///
  /// - Parameters:
  ///   - term: The entered text for the search.
  ///   - types: The types of music items to include in the search.
  ///   - limit: The number of objects returned.
  ///   - offset: The next page of group of objects to fetch.
  /// - Returns: `MusicCatalogSearchResponse` that returns different music items.
  static func search(
    for term: String,
    types: [MusicCatalogSearchType],
    limit: Int? = nil,
    offset: Int? = nil,
    includeTopResults: Bool = false
  ) async throws -> MusicCatalogSearchResponse {
    let searchTypes = types.compactMap { $0.type }
    var request = MusicCatalogSearchRequest(term: term, types: searchTypes)
    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      request.includeTopResults = includeTopResults
    }
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response
  }

  static func searchSongs(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Songs {
    var request = MusicCatalogSearchRequest(term: term, types: [Song.self])
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.songs
  }

  static func searchPlaylists(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Playlists {
    var request = MusicCatalogSearchRequest(term: term, types: [Playlist.self])
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.playlists
  }

  static func searchAlbums(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Albums {
    var request = MusicCatalogSearchRequest(term: term, types: [Album.self])
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.albums
  }

  static func searchArtists(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Artists {
    var request = MusicCatalogSearchRequest(term: term, types: [Artist.self])
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.artists
  }

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
  static func searchMusicVideos(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> MusicVideos {
    var request = MusicCatalogSearchRequest(term: term, types: [MusicVideo.self])
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.musicVideos
  }

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
  static func searchCurators(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Curators {
    var request = MusicCatalogSearchRequest(term: term, types: [Curator.self])
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.curators
  }

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
  static func searchRadioShows(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> RadioShows {
    var request = MusicCatalogSearchRequest(term: term, types: [RadioShow.self])
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.radioShows
  }

  static func searchStations(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Stations {
    var request = MusicCatalogSearchRequest(term: term, types: [Station.self])
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.stations
  }
}

public extension MCatalog {
  /// Fetch top results and search suggestions from the Apple Music catalog by using a query term.
  ///
  /// - Parameters:
  ///   - term: The entered text for the search.
  ///   - types: The types of music items to include in the search.
  ///   - limit: The number of objects returned.
  /// - Returns: `MusicCatalogSearchSuggestionsResponse` that returns different top music items and suggestions.
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
  static func searchSuggestions(
    for term: String,
    types: [MusicCatalogSearchType],
    limit: Int? = nil
  ) async throws -> MusicCatalogSearchSuggestionsResponse {
    let searchTypes = types.compactMap { $0.type }
    var request = MusicCatalogSearchSuggestionsRequest(
      term: term, includingTopResultsOfTypes: searchTypes)
    request.limit = limit
    let response = try await request.response()
    return response
  }

  /// Fetch search suggestions from the Apple Music catalog by using a query term.
  ///
  /// - Parameters:
  ///   - term: The entered text for the search.
  ///   - limit: The number of objects returned.
  /// - Returns: `[MusicCatalogSearchSuggestionsResponse.Suggestion]` which is an array of  suggestions.
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
  static func suggestions(for term: String, limit: Int? = nil) async throws
    -> [MusicCatalogSearchSuggestionsResponse.Suggestion] {
    var request = MusicCatalogSearchSuggestionsRequest(term: term)
    request.limit = limit
    let response = try await request.response()
    return response.suggestions
  }
}
