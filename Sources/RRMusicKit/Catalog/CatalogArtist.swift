//
//  CatalogArtist.swift
//  CatalogArtist
//
//  Created by Rudrank Riyam on 25/08/21.
//

import MusicKit

public typealias Artists = MusicItemCollection<Artist>

public extension RRMusicKit {
    static func catalogArtist(id: MusicItemID) async throws -> Artists {
        let musicRequest = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: id)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogArtists(ids: [MusicItemID]) async throws -> Artists {
        let musicRequest = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogArtist(id: MusicItemID, with relationships: [PartialMusicAsyncProperty<Artist>]) async throws -> Artists {
        var musicRequest = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: id)
        musicRequest.properties = relationships
        let response = try await musicRequest.response()
        
        return response.items
    }
}
