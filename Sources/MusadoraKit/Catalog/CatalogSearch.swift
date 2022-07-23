//
//  CatalogSearch.swift
//  CatalogSearch
//
//  Created by Rudrank Riyam on 20/08/21.
//

import Foundation
import MusicKit

public enum MusicCatalogSearchType {
  case songs
  case albums
  case playlists
  case artists
  case stations
  case recordLabels

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
  case musicVideos, curators, radioShows

  public var type: MusicCatalogSearchable.Type? {
    switch self {
      case .songs:
        return Song.self
      case .albums:
        return Album.self
      case .playlists:
        return Playlist.self
      case .artists:
        return Artist.self
      case .stations:
        return Station.self
      case .recordLabels:
        return RecordLabel.self

      case .musicVideos:
        if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *) {
          return MusicVideo.self
        } else {
          return nil
        }
      case .curators:
        if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *) {
          return Curator.self
        } else {
          return nil
        }
      case .radioShows:
        if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *) {
          return RadioShow.self
        } else {
          return nil
        }
    }
  }
}

public extension MusadoraKit {
  /// Search the Apple Music catalog by using a query term.
  /// - Parameters:
  ///   - term: The entered text for the search.
  ///   - types: The types of music items to include in the search.
  ///   - limit: The number of objects returned.
  ///   - offset: The next page of group of objects to fetch.
  /// - Returns: `MusicCatalogSearchResponse` that returns different music items.
  static func catalogSearch(for term: String,
                            types: [MusicCatalogSearchType],
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicCatalogSearchResponse {
    let searchTypes = types.compactMap { $0.type }
    var request = MusicCatalogSearchRequest(term: term, types: searchTypes)
    // request.includeTopResults = includeTopResults /// Waiting for Beta 4 for it to be fixed.
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response
  }
}

#if compiler(>=5.7)
public extension MusadoraKit {
  /// Fetch top results and search suggestions from the Apple Music catalog by using a query term.
  /// - Parameters:
  ///   - term: The entered text for the search.
  ///   - types: The types of music items to include in the search.
  ///   - limit: The number of objects returned.
  /// - Returns: `MusicCatalogSearchSuggestionsResponse` that returns different top music items and suggestions.
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  static func catalogSearch(for term: String,
                            types: [MusicCatalogSearchType] = [],
                            limit: Int? = nil) async throws -> MusicCatalogSearchSuggestionsResponse {
    let searchTypes = types.compactMap { $0.type }
    var request = MusicCatalogSearchSuggestionsRequest(term: term, includingTopResultsOfTypes: searchTypes)
    request.limit = limit
    let response = try await request.response()
    return response
  }

  /// Fetch search suggestions from the Apple Music catalog by using a query term.
  /// - Parameters:
  ///   - term: The entered text for the search.
  ///   - types: The types of music items to include in the search.
  ///   - limit: The number of objects returned.
  /// - Returns: `[MusicCatalogSearchSuggestionsResponse.Suggestion]` which is an array of  suggestions.
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  static func catalogSearch(for term: String,
                            limit: Int? = nil) async throws -> [MusicCatalogSearchSuggestionsResponse.Suggestion] {
    var request = MusicCatalogSearchSuggestionsRequest(term: term)
    request.limit = limit
    let response = try await request.response()
    return response.suggestions
  }
}
#endif
