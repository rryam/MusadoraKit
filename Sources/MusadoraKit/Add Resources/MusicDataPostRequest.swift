//
//  MusicDataPostRequest.swift
//  MusicDataPostRequest
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation
import MusicKit

/// A request for uploading data from an arbitrary Apple Music API endpoint.
public struct MusicDataPostRequest {

    /// The URL request for the data request.
    public var urlRequest: URLRequest

    /// Creates a data request with a URL request.
    public init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }

    /// Uploads data the Apple Music API endpoint that
    /// the URL request defines.
    public mutating func response() async throws -> MusicDataPostResponse {
        try await updateURLRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        return MusicDataPostResponse(data: data, urlResponse: response as! HTTPURLResponse)
    }

    private mutating func updateURLRequest() async throws {
        let developerToken = try await MusicDataRequest.tokenProvider.developerToken(options: .ignoreCache)
        let userToken = try await MusicDataRequest.tokenProvider.userToken(for: developerToken, options: .ignoreCache)

        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
    }
}

/// An object containing results for a post data request.
public struct MusicDataPostResponse {

    /// The raw data returned by the Apple Music API endpoint
    /// for the originating data request.
    public let data: Data

    /// The URL response returned by the Apple Music API endpoint
    /// for the originating data request.
    public let urlResponse: HTTPURLResponse
}
