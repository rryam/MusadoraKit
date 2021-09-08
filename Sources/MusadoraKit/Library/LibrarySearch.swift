//
//  LibrarySearch.swift
//  LibrarySearch
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

public extension MusadoraKit {
    static func librarySearch(for term: String,
                              types: [MusicLibrarySearchable.Type],
                              limit: Int?,
                              offset: Int?) async throws -> MusicLibrarySearchResponse {
        var request = MusicLibrarySearchRequest(term: term, types: types)
        request.limit = limit
        request.offset = offset
        
        return try await request.response()
    }
}
