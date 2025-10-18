//
//  MusicRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 20/04/25.
//

import Foundation

/// A protocol defining the requirements for making an Apple Music API request.
///
/// Conforming types specify how to construct the request URL and decode the response data.
protocol MusicRequest {
    /// The expected decodable type for the API response.
    associatedtype ResponseType: Decodable

    /// The URL for the API request.
    /// This property can throw an error if URL construction fails.
    var url: URL { get throws }

    /// Decodes the raw data received from the API into the specified `ResponseType`.
    /// - Parameter data: The raw `Data` received from the API response.
    /// - Returns: An instance of the `ResponseType`.
    /// - Throws: An error if decoding fails.
    func decodeResponse(data: Data) throws -> ResponseType
}

extension MusicRequest {
    func perform() async throws -> ResponseType {
        let request = MusicDataRequest(urlRequest: URLRequest(url: try url))
        let response = try await request.response()
        return try decodeResponse(data: response.data)
    }
}
