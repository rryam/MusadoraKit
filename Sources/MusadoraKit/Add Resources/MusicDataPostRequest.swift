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

    /// The URL for the data request.
    public var url: URL

    /// Creates a data request with the given URL.
    public init(url: URL) {
        self.url = url
    }

    /// Uploads data the Apple Music API endpoint that
    /// the URL request defines.
    public func response() async throws -> MusicDataPostResponse {
        let developerToken = try await MusicDataRequest.tokenProvider.developerToken(options: .ignoreCache)
        let userToken = try await MusicDataRequest.tokenProvider.userToken(for: developerToken, options: .ignoreCache)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        return MusicDataPostResponse(data: data, urlResponse: response as! HTTPURLResponse)
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
