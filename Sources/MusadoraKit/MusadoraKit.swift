//
//  MusadoraKit.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 04/08/21.
//

import MusicKit
import Foundation

public struct MusadoraKit {
    static func decode<Model: Decodable>(endpoint: AppleMusicEndpoint) async throws -> Model {
        let url = try await endpoint.url
        let dataRequest = MusicDataRequest(urlRequest: URLRequest(url: url))
        let dataResponse = try await dataRequest.response()
        
        let response = try JSONDecoder().decode(Model.self, from: dataResponse.data)
        
        return response
    }
}
