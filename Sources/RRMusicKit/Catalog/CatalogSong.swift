//
//  CatalogSong.swift
//  CatalogSong
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

// MARK: - REQUESTING CATALOG SONG
public extension RRMusicKit {
     static func catalogSong(id: MusicItemID) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogSongs(ids: [MusicItemID]) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogSongs(isrc: [String]) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.isrc, memberOf: isrc)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogSongRelationship(id: MusicItemID, relationships: [PartialMusicAsyncProperty<Song>]) async throws -> MusicItemCollection<Song> {
        var musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        musicRequest.properties = relationships
        
        let response = try await musicRequest.response()
        
        return response.items
    }
}
