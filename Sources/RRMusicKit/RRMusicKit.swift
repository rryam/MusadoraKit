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
        
        print("***DATA FOR PATH \(endpoint.path) IS***")
        print(dataResponse.data.prettyPrintedJSONString)
        
        let response = try decoder.decode(Model.self, from: dataResponse.data)
        
        return response
    }
}
