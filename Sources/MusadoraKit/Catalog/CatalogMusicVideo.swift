//
//  CatalogMusicVideo.swift
//  CatalogMusicVideo
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

public typealias MusicVideos = MusicItemCollection<MusicVideo>

public extension MusadoraKit {
    static func catalogMusicVideo(id: MusicItemID) async throws -> MusicVideos {
        let request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, equalTo: id)
        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogMusicVideos(ids: [MusicItemID]) async throws -> MusicVideos {
        let request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, memberOf: ids)
        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogMusicVideo(isrc: String) async throws -> MusicVideos {
        let request = MusicCatalogResourceRequest<MusicVideo>(matching: \.isrc, equalTo: isrc)
        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogMusicVideos(isrc: [String]) async throws -> MusicVideos {
        let request = MusicCatalogResourceRequest<MusicVideo>(matching: \.isrc, memberOf: isrc)
        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogMusicVideo(id: MusicItemID, with relationships: [PartialMusicAsyncProperty<MusicVideo>]) async throws -> MusicVideos {
        var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, equalTo: id)
        request.properties = relationships
        let response = try await request.response()
        
        return response.items
    }
}
