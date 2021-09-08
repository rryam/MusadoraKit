//
//  CatalogAlbum.swift
//  CatalogAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

public typealias Albums = MusicItemCollection<Album>

public extension MusadoraKit {
    static func catalogAlbum(id: MusicItemID) async throws -> Albums {
        let request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogAlbums(ids: [MusicItemID]) async throws -> Albums {
        let request = MusicCatalogResourceRequest<Album>(matching: \.id, memberOf: ids)
        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogAlbums(isrc: String) async throws -> Albums {
        let request = MusicCatalogResourceRequest<Album>(matching: \.upc, equalTo: isrc)
        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogAlbums(isrc: [String]) async throws -> Albums {
        let request = MusicCatalogResourceRequest<Album>(matching: \.upc, memberOf: isrc)
        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogAlbum(id: MusicItemID, with relationships: [PartialMusicAsyncProperty<Album>]) async throws -> Albums {
        var request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
        request.properties = relationships
        let response = try await request.response()
        
        return response.items
    }
}
