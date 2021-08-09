//
//  MusicKitManager.swift
//  MusicKitManager
//
//  Created by Rudrank Riyam on 04/08/21.
//

import MusicKit
import Foundation

public class MusicKitManager {
    var storeFront: String?
    
    public static let shared = MusicKitManager()
    
    public init() {
        Task {
            self.storeFront = try await MusicDataRequest.currentCountryCode
        }
    }
    
    public func getGenres() async throws -> Genres {
        return try await decode(endpoint: .genres())
    }

    
    public func decode<Model: Decodable>(endpoint: AppleMusicEndPoint) async throws -> Model {
        let dataRequest = MusicDataRequest(urlRequest: URLRequest(url: endpoint.url))
        let dataResponse = try await dataRequest.response()
        
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(Model.self, from: dataResponse.data)
        
        return response
    }
}

// MARK: - REQUESTING A CATALOG SONG
extension MusicKitManager {
    public func getCatalogSong(id: MusicItemID) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    public func getMultipleCatalogSongs(ids: [MusicItemID]) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    public func getMultipleCatalogSongs(isrc: [String]) async throws -> MusicItemCollection<Song> {
        let musicRequest = MusicCatalogResourceRequest<Song>(matching: \.isrc, memberOf: isrc)
        let response = try await musicRequest.response()
        
        return response.items
    }
    
    public func getCatalogSongRelationship(id: MusicItemID, relationships: [PartialMusicAsyncProperty<Song>]) async throws -> MusicItemCollection<Song> {
        var musicRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        musicRequest.properties = relationships
        
        let response = try await musicRequest.response()
        
        return response.items
    }
}


