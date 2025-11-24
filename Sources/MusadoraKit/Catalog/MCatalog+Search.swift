//
//  CatalogSearch.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 20/08/21.
//

// MARK: - Generic Search Helper
private extension MCatalog {
    private static func search<ResponseType, ItemType: MusicCatalogSearchable>(
        for term: String,
        itemType: ItemType.Type,
        keyPath: KeyPath<MusicCatalogSearchResponse, ResponseType>,
        limit: Int?,
        offset: Int?
    ) async throws -> ResponseType {
        var request = MusicCatalogSearchRequest(term: term, types: [itemType])
        request.limit = limit
        request.offset = offset
        let response = try await request.response()
        return response[keyPath: keyPath]
    }
}

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
    includeTopResults: Bool = true
  ) async throws -> MusicCatalogSearchResponse {
    let searchTypes = types.compactMap { $0.type }

    guard !searchTypes.isEmpty else {
        throw MusadoraKitError.notFound(for: term)
    }

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
    try await search(for: term, itemType: Song.self, keyPath: \.songs, limit: limit, offset: offset)
  }

  static func searchPlaylists(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Playlists {
    try await search(for: term, itemType: Playlist.self, keyPath: \.playlists, limit: limit, offset: offset)
  }

  static func searchAlbums(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Albums {
    try await search(for: term, itemType: Album.self, keyPath: \.albums, limit: limit, offset: offset)
  }

  static func searchArtists(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Artists {
    try await search(for: term, itemType: Artist.self, keyPath: \.artists, limit: limit, offset: offset)
  }

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
  static func searchMusicVideos(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> MusicVideos {
    try await search(for: term, itemType: MusicVideo.self, keyPath: \.musicVideos, limit: limit, offset: offset)
  }

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
  static func searchCurators(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Curators {
    try await search(for: term, itemType: Curator.self, keyPath: \.curators, limit: limit, offset: offset)
  }

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
  static func searchRadioShows(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> RadioShows {
    try await search(for: term, itemType: RadioShow.self, keyPath: \.radioShows, limit: limit, offset: offset)
  }

  static func searchStations(
    for term: String,
    limit: Int? = nil,
    offset: Int? = nil
  ) async throws -> Stations {
    try await search(for: term, itemType: Station.self, keyPath: \.stations, limit: limit, offset: offset)
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
