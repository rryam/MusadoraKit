//
//  CatalogPlaylist.swift
//  CatalogPlaylist
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

public typealias Playlists = MusicItemCollection<Playlist>

public extension MusadoraKit {
    static func catalogPlaylist(id: MusicItemID, limit: Int? = nil, with properties: [PartialMusicAsyncProperty<Playlist>] = []) async throws -> Playlist {
        var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()

        guard let playlist = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }

        return playlist
    }
    
    static func catalogPlaylists(ids: [MusicItemID], limit: Int? = nil, with properties: [PartialMusicAsyncProperty<Playlist>] = []) async throws -> Playlists {
        var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()
        
        return response.items
    }
}
