//
//  LibrarySearch.swift
//  LibrarySearch
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

public extension MusadoraKit {
  /// Search the user's library by using a query.
  /// - Parameters:
  ///   - term: The text for the search
  ///   - types: The list of the types of resources to include in the results.
  ///   - limit: The number of objects returned. Default: 5, maximum Value: 25
  ///   - offset: The next page or group of objects to fetch.
  /// - Returns: `MusicLibrarySearchResponse` that contains results for a library search request.
  static func librarySearch(for term: String,
                            types: [MusicLibrarySearchable.Type],
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicLibrarySearchResponse
  {
    var request = MusicLibrarySearchRequest(term: term, types: types)
    request.limit = limit
    request.offset = offset
    return try await request.response()
  }
}
