//
//  CatalogSong.swift
//  CatalogSong
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

public typealias Songs = MusicItemCollection<Song>

public extension MusadoraKit {
    static func catalogSong(id: MusicItemID) async throws -> Songs {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogSongs(ids: [MusicItemID]) async throws -> Songs {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogSongs(isrc: [String]) async throws -> Songs {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.isrc, memberOf: isrc)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogSongRelationship(id: MusicItemID, relationships: [PartialMusicAsyncProperty<Song>]) async throws -> Songs {
        var musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        musicRequest.properties = relationships
        
        let response = try await musicRequest.response()
        
        return response.items
    }
}
