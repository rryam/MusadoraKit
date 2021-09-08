//
//  CatalogPlaylist.swift
//  CatalogPlaylist
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

public typealias Playlists = MusicItemCollection<Playlist>

public extension MusadoraKit {
    static func playlist(id: MusicItemID) async throws -> Playlists {
        let request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
        let response = try await request.response()
        
        return response.items
    }
    
    static func playlists(ids: [MusicItemID]) async throws -> Playlists {
        let request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
        let response = try await request.response()
        
        return response.items
    }
    
    static func playlist(id: MusicItemID, with relationships: [PartialMusicAsyncProperty<Playlist>]) async throws -> Playlists {
        var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
        request.properties = relationships
        let response = try await request.response()
        
        return response.items
    }
}
