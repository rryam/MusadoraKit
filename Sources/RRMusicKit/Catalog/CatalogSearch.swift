//
//  CatalogSearch.swift
//  CatalogSearch
//
//  Created by Rudrank Riyam on 20/08/21.
//

import Foundation
import MusicKit

public enum SearchTypes: String {
    case activities
    case albums
    case appleCurators
    case artists
    case curators
    case musicVideos
    case playlists
    case recordLabels
    case songs
    case stations
    
    var type: String {
        switch self {
            case .appleCurators: return "apple-curators"
            case .musicVideos: return "music-videos"
            case .recordLabels: return "record-labels"
            default: return rawValue
        }
    }
}

extension AppleMusicEndpoint {
    static func search(for term: String, limit: Int, types: [SearchTypes]) -> Self {
        let termQuery = URLQueryItem(name: "term", value: term.replacingOccurrences(of: " ", with: "+"))
        let types = types.map { String($0.type) }.joined(separator: ",")
        
        let typesQuery = URLQueryItem(name: "types", value: types)
        
        let limitQuery = URLQueryItem(name: "limit", value: String(describing: limit))
        
        let queryItems = [termQuery, limitQuery, typesQuery]
        
        return AppleMusicEndpoint(library: .catalog, "search", queryItems: queryItems)
    }
}

#warning("The search API returns a mix of a lot of stuff. Need to figure out a way to do that.")
public extension RRMusicKit {
    static func search(for term: String, limit: Int = 20, types: [SearchTypes] = [.songs]) async throws -> [Song] {
        let model: SearchSongModel = try await self.decode(endpoint: .search(for: term, limit: limit, types: types))
        return model.results.songs.data
    }
}


// MARK: - SearchSongModel
public struct SearchSongModel: Codable {
    let results: SearchSongResults
}

// MARK: - SearchSongResults
public struct SearchSongResults: Codable {
    let songs: SearchSongs
}

// MARK: - WelcomeResults
public struct SearchSongs: Codable {
    let data: [Song]
}
