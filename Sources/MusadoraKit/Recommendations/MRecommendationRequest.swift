//
//  MusicRecommendationRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

/// A  request that your app uses to fetch recommendations from
/// the user's library, either default ones or based on identifiers.
struct MRecommendationRequest {
  /// A limit for the number of items to return
  /// in the recommendation response.
  var limit: Int?

  private var ids: [String]?

  /// Creates a request to fetch default recommendations.
  init() {}

  /// Creates a request to fetch a recommendation by using its identifier.
  init(equalTo id: String) {
    ids = [id]
  }

  /// Creates a request to fetch one or more recommendations by using their identifiers.
  init(memberOf ids: [String]) {
    self.ids = ids
  }

  /// Fetches recommendations based on the user’s library
  /// and purchase history for the given request.
  func response() async throws -> MRecommendationResponse {
    let items: MRecommendations
    let url = try recommendationEndpointURL
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    if let userToken = MusadoraKit.userToken {
      let request = MUserRequest(urlRequest: .init(url: url), userToken: userToken)
      let data = try await request.response()
      items = try decoder.decode(MRecommendations.self, from: data)
    } else {
      let request = MusicDataRequest(urlRequest: .init(url: url))
      let response = try await request.response()
      items = try decoder.decode(MRecommendations.self, from: response.data)
    }

    return MRecommendationResponse(items: items)
  }
}

extension MRecommendationRequest {
  var recommendationEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []
      components.path = "me/recommendations"

      if let ids = ids {
        queryItems.append(URLQueryItem(name: "ids", value: ids.joined(separator: ",")))
      }

      if let limit = limit {
        guard limit <= 30 else {
          throw MusadoraKitError.recommendationOverLimit(for: limit)
        }

        queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
      }

      components.queryItems = queryItems.isEmpty ? nil : queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
