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
            var path: LibraryMusicItemType?

            components.scheme = "https"
            components.host = "api.music.apple.com"

            switch self {
                case is Song: path = .songs
                case is Album: path = .albums
                case is Artist.Type: path = .artists
                case is MusicVideo: path = .musicVideos
                case is Playlist: path = .playlists
                default: path = nil
            }

            guard let path = path else {
                throw URLError(.badURL)
            }

            components.path = "/v1/me/library/\(path.rawValue)/\(self.id.rawValue)/catalog"

            guard let url = components.url else {
                throw URLError(.badURL)
            }

            let request = MusicDataRequest(urlRequest: .init(url: url))
            let response = try await request.response()

            let items = try JSONDecoder().decode(MusicItemCollection<Self>.self, from: response.data)

            guard let item = items.first else {
                throw MusadoraKitError.notFound(for: self.id.rawValue)
            }
            return item
        }
    }
}
