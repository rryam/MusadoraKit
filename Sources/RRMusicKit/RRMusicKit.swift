//
//  RRMusicKit.swift
//  RRMusicKit
//
//  Created by Rudrank Riyam on 04/08/21.
//

import MusicKit
import Foundation

public class RRMusicKit {
    public static func genres() async throws -> Genres {
        return try await decode(endpoint: .genres)
    }
    
    public static func decode<Model: Decodable>(endpoint: AppleMusicEndPoint) async throws -> Model {
        let url = await endpoint.url()
        let dataRequest = MusicDataRequest(urlRequest: URLRequest(url: url))
        let dataResponse = try await dataRequest.response()
        
        print("DATA RESPONSE IS \(String(describing: dataResponse.data.prettyPrintedJSONString))")
        
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(Model.self, from: dataResponse.data)
        
        return response
    }
}

// MARK: - REQUESTING A CATALOG SONG
extension RRMusicKit {
    public static func getCatalogSong(id: MusicItemID) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    public static func getMultipleCatalogSongs(ids: [MusicItemID]) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    public static func getMultipleCatalogSongs(isrc: [String]) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.isrc, memberOf: isrc)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    public static func getCatalogSongRelationship(id: MusicItemID, relationships: [PartialMusicAsyncProperty<Song>]) async throws -> MusicItemCollection<Song> {
        var musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        musicRequest.properties = relationships
        
        let response = try await musicRequest.response()
        
        return response.items
    }
}

// MARK: - REQUESTING USER LIBRARY
extension RRMusicKit {
    public static func recentlyPlayedSongs() async throws -> [Song] {
        let songs: Songs = try await self.decode(endpoint: .recent)
        return songs.data
    }
}
