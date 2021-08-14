//
//  RRMusicKit.swift
//  RRMusicKit
//
//  Created by Rudrank Riyam on 04/08/21.
//

import MusicKit
import Foundation

public class RRMusicKit {
    static func decode<Model: Decodable>(endpoint: AppleMusicEndpoint) async throws -> Model {
        let url = await endpoint.url()
        let dataRequest = MusicDataRequest(urlRequest: URLRequest(url: url))
        let dataResponse = try await dataRequest.response()
        
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(Model.self, from: dataResponse.data)
        
        return response
    }
}

public extension RRMusicKit {
    static func genres() async throws -> Genres {
        try await decode(endpoint: .genres)
    }
}

// MARK: - REQUESTING USER LIBRARY
public extension RRMusicKit {
    static func recentlyPlayedSongs() async throws -> MusicItemCollection<Song> {
        try await self.decode(endpoint: .recent)
    }
}

