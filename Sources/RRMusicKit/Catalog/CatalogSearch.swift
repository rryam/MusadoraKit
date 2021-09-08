//
//  CatalogSearch.swift
//  CatalogSearch
//
//  Created by Rudrank Riyam on 20/08/21.
//

import Foundation
import MusicKit

public extension RRMusicKit {
    static func catalogSearch(for term: String,
                       types: [MusicCatalogSearchable.Type],
                       limit: Int?,
                       offset: Int?) async throws -> MusicCatalogSearchResponse {
        var request = MusicCatalogSearchRequest(term: term, types: types)
        request.limit = limit
        request.offset = offset
        
        return try await request.response()
    }
}
