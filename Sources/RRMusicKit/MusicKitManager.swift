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
    
    static let shared = MusicKitManager()
    
    init() {
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
