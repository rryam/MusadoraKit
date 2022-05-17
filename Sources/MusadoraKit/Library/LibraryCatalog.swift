//
//  LibraryCatalog.swift
//  LibraryCatalog
//
//  Created by Rudrank Riyam on 10/05/22.
//

import Foundation
import MusicKit

extension FilterableLibraryItem {
    public var catalog: Self {
        get async throws {
            var components = URLComponents()
            let path: LibraryMusicItemType
            
            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = "/v1/me/library/"
            
            switch self {
                case is Song: path = .songs
                case is Album: path = .albums
                case is Artist: path = .artists
                case is MusicVideo: path = .musicVideos
                case is Playlist: path = .playlists
                default: throw NSError(domain: "Wrong library music item type.", code: 0)
            }
            
            components.path += "\(path.rawValue)/\(id.rawValue)/catalog"
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            let request = MusicDataRequest(urlRequest: .init(url: url))
            let response = try await request.response()
            let items = try JSONDecoder().decode(MusicItemCollection<Self>.self, from: response.data)
            
            guard let item = items.first else {
                throw MusadoraKitError.notFound(for: id.rawValue)
            }
            return item
        }
    }
}
