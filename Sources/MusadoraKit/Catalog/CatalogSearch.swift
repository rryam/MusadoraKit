//
//  CatalogSearch.swift
//  CatalogSearch
//
//  Created by Rudrank Riyam on 20/08/21.
//

import Foundation
import MusicKit

public extension MusadoraKit {
    
    /// Search the Apple Music catalog by using a query term.
    /// - Parameters:
    ///   - term: The entered text for the search.
    ///   - types: The types of music items to include in the search.
    ///   - limit: The number of objects returned.
    ///   - offset: The next page of group of objects to fetch.
    /// - Returns: `MusicCatalogSearchResponse` that returns different music items.
    static func catalogSearch(for term: String,
                       types: [MusicCatalogSearchable.Type],
                       limit: Int? = nil,
                       offset: Int? = nil) async throws -> MusicCatalogSearchResponse {
        var request = MusicCatalogSearchRequest(term: term, types: types)
        request.limit = limit
        request.offset = offset
        let response = try await request.response()
        return response
    }
}
