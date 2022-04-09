//
//  CatalogAlbum.swift
//  CatalogAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

public typealias Albums = MusicItemCollection<Album>

public extension MusadoraKit {
    static func catalogAlbum(id: MusicItemID,
                             with properties: [PartialMusicAsyncProperty<Album>] = []) async throws -> Album {
        var request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
        request.properties = properties

        let response = try await request.response()
        
        guard let album = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }

        return album
    }
    
    static func catalogAlbums(ids: [MusicItemID],
                              limit: Int? = nil,
                              with properties: [PartialMusicAsyncProperty<Album>] = []) async throws -> Albums {
        var request = MusicCatalogResourceRequest<Album>(matching: \.id, memberOf: ids)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogAlbums(isrc: String,
                              with properties: [PartialMusicAsyncProperty<Album>] = []) async throws -> Album {
        var request = MusicCatalogResourceRequest<Album>(matching: \.upc, equalTo: isrc)
        request.properties = properties

        let response = try await request.response()
        
        guard let album = response.items.first else {
            throw MusadoraKitError.notFound(for: isrc)
        }

        return album
    }
    
    static func catalogAlbums(isrc: [String],
                              limit: Int? = nil,
                              with properties: [PartialMusicAsyncProperty<Album>] = []) async throws -> Albums {
        var request = MusicCatalogResourceRequest<Album>(matching: \.upc, memberOf: isrc)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()
        
        return response.items
    }
}
