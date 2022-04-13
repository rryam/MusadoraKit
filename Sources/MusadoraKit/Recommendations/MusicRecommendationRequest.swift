//
//  MusicRecommendationRequest.swift
//  MusicRecommendationRequest
//
//  Created by Rudrank Riyam on 02/04/22.
//

import MusicKit
import Foundation

/// A  request that your app uses to fetch recommendations from
/// the user's library, either default ones or based on identifiers.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct MusicRecommendationRequest {

    /// A limit for the number of items to return
    /// in the recommendation response.
    public var limit: Int?

    /// Creates a request to fetch default recommendations.
    public init() {}

    /// Creates a request to fetch one or more recommendations by using their identifiers.
    public init(ids: [String]) {
        self.ids = ids
    }

    private var ids: [String]?

    /// Fetches recommendations based on the user’s library
    /// and purchase history for the given request.
    public func response() async throws -> MusicRecommendationResponse {
        let url = try recommendationEndpointURL
        let request = MusicDataRequest(urlRequest: .init(url: url))
        let response = try await request.response()
        let items = try JSONDecoder().decode(Recommendations.self, from: response.data)

        return MusicRecommendationResponse(items: items)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension MusicRecommendationRequest {
    private var recommendationEndpointURL: URL {
        get throws {
            var components = URLComponents()
            var queryItems: [URLQueryItem]?

            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = "/v1/me/recommendations"
            
            if let ids = ids {
                queryItems = [URLQueryItem(name: "ids", value: ids.joined(separator: ","))]
            } else if let limit = limit {
                queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]
            }

            components.queryItems = queryItems

            guard let url = components.url else {
                throw URLError(.badURL)
            }

            return url
        }
    }
}
