//
//  LibraryCatalog.swift
//  LibraryCatalog
//
//  Created by Rudrank Riyam on 10/05/22.
//

import Foundation
import MusicKit

fileprivate func fetchCatalog<Item>(item: Item, path: LibraryMusicItemType) async throws -> Item where Item: MusicItem, Item: Decodable {
    var components = URLComponents()

    components.scheme = "https"
    components.host = "api.music.apple.com"
    components.path = "/v1/me/library/\(path.rawValue)/\(item.id.rawValue)/catalog"

    guard let url = components.url else {
        throw URLError(.badURL)
    }

    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()

    let items = try JSONDecoder().decode(MusicItemCollection<Item>.self, from: response.data)

    guard let item = items.first else {
        throw MusadoraKitError.notFound(for: item.id.rawValue)
    }
    return item
}

extension Album {
    /// Fetch the equivalent catalog album for the given album in user's iCloud library.
    public var catalog: Album {
        get async throws {
            try await fetchCatalog(item: self, path: .albums)
        }
    }
}

extension Song {
    /// Fetch the equivalent catalog song for the given song in user's iCloud library.
    public var catalog: Song {
        get async throws {
            try await fetchCatalog(item: self, path: .songs)
        }
    }
}

extension Artist {
    /// Fetch the equivalent catalog artist for the given artist in user's iCloud library.
    public var catalog: Artist {
        get async throws {
            try await fetchCatalog(item: self, path: .artists)
        }
    }
}

extension Playlist {
    /// Fetch the equivalent catalog playlist for the given playlist in user's iCloud library.
    public var catalog: Playlist {
        get async throws {
            try await fetchCatalog(item: self, path: .playlists)
        }
    }
}

extension Track {
    /// Fetch the equivalent catalog track for the given track in user's iCloud library.
    public var catalog: Track {
        get async throws {
            switch self {
                case .song:
                    return try await fetchCatalog(item: self, path: .songs)
                case .musicVideo:
                    return try await fetchCatalog(item: self, path: .musicVideos)
            }
        }
    }
}
