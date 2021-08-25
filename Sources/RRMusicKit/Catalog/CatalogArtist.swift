//
//  CatalogArtist.swift
//  CatalogArtist
//
//  Created by Rudrank Riyam on 25/08/21.
//

import Foundation
import MusicKit

public extension RRMusicKit {
    static func catalogArtist(id: MusicItemID) async throws -> MusicItemCollection<Artist> {
        let musicRequest = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo:id)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogArtists(ids: [MusicItemID]) async throws -> MusicItemCollection<Artist> {
        let musicRequest = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    static func catalogArtist(id: MusicItemID, with relationships: [PartialMusicAsyncProperty<Artist>]) async throws -> MusicItemCollection<Artist> {
        var musicRequest = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: id)
        musicRequest.properties = relationships
        let response = try await musicRequest.response()
        
        return response.items
    }
}
