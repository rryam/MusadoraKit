//
//  MusicTokenRequest.swift
//  MusicTokenRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public struct MusicTokenRequest {
    public var urlRequest: URLRequest

    public init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }

    public mutating func response() async throws -> MusicDataPostResponse {
        let developerToken = try await MusicDataRequest.tokenProvider.developerToken(options: .ignoreCache)
        let userToken = try await MusicDataRequest.tokenProvider.userToken(for: developerToken, options: .ignoreCache)

        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        return MusicDataPostResponse(data: data, urlResponse: response as! HTTPURLResponse)
    }
}
