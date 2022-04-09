//
//  CatalogSong.swift
//  CatalogSong
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

public typealias Songs = MusicItemCollection<Song>

public extension MusadoraKit {
    static func catalogSong(id: MusicItemID,
                            limit: Int? = nil,
                            with properties: [PartialMusicAsyncProperty<Song>] = []) async throws -> Song {
        var request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()
        
        guard let song = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }

        return song
    }
    
    static func catalogSongs(ids: [MusicItemID],
                             limit: Int? = nil,
                             with properties: [PartialMusicAsyncProperty<Song>] = []) async throws -> Songs {
        var request = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()
        
        return response.items
    }
    
    static func catalogSongs(isrc: [String],
                             limit: Int? = nil,
                             with properties: [PartialMusicAsyncProperty<Song>] = []) async throws -> Songs {
        var request = MusicCatalogResourceRequest<Song>(matching: \.isrc, memberOf: isrc)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()
        
        return response.items
    }
}
