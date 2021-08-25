//
//  CatalogAlbum.swift
//  CatalogAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

public extension RRMusicKit {
    static func catalogAlbum(id: MusicItemID) async throws -> MusicItemCollection<Album> {
        let musicRequest = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogAlbums(ids: [MusicItemID]) async throws -> MusicItemCollection<Album> {
        let musicRequest = MusicCatalogResourceRequest<Album>(matching: \.id, memberOf: ids)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogAlbums(isrc: [String]) async throws -> MusicItemCollection<Album> {
        let musicRequest = MusicCatalogResourceRequest<Album>(matching: \.upc, memberOf: isrc)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogAlbum(id: MusicItemID, with relationships: [PartialMusicAsyncProperty<Album>]) async throws -> MusicItemCollection<Album> {
        var musicRequest = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
        musicRequest.properties = relationships
        let response = try await musicRequest.response()
        
        return response.items
    }
}
