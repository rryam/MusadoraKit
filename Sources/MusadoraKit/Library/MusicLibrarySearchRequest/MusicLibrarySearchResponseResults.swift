//
//  MusicLibrarySearchResponseResults.swift
//  MusicLibrarySearchResponseResults
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// The results from the library search request using a search term.
struct MusicLibrarySearchResponseResults: Decodable {
    var results: MusicLibrarySearchResponse
}

extension MusicLibrarySearchResponseResults : CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        var description = "MusicLibrarySearchResponseResults("
        let mirror = Mirror(reflecting: self)
        
        description += mirror.children.map { "\n\($0.value)," }.joined()
        
        return description + "\n)"
    }
    
    public var debugDescription: String {
        "MusicLibrarySearchResponseResults(\n\(self.results))"
    }
}
