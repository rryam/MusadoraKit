//
//  CatalogArtist.swift
//  CatalogArtist
//
//  Created by Rudrank Riyam on 25/08/21.
//

import MusicKit

public typealias Artists = MusicItemCollection<Artist>

public extension MusadoraKit {
    static func catalogArtist(id: MusicItemID,
                              limit: Int? = nil,
                              with properties: [PartialMusicAsyncProperty<Artist>] = []) async throws -> Artist {

        var request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: id)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()

        guard let artist = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }

        return artist
    }
    
    static func catalogArtists(ids: [MusicItemID],
                               limit: Int? = nil,
                               with properties: [PartialMusicAsyncProperty<Artist>] = []) async throws -> Artists {

        var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
        request.limit = limit
        request.properties = properties

        let response = try await request.response()
        return response.items
    }
}
