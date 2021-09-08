//
//  MusicLibrarySearchResponseResults.swift
//  MusicLibrarySearchResponseResults
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// The results from the library search request using a search term.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct MusicLibrarySearchResponseResults: Decodable {
    var results: MusicLibrarySearchResponse
}
