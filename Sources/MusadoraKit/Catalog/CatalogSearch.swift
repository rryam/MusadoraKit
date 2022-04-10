//
//  CatalogSearch.swift
//  CatalogSearch
//
//  Created by Rudrank Riyam on 20/08/21.
//

import Foundation
import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MusadoraKit {
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
