//
//  MusicRecommendationRequest.swift
//  MusicRecommendationRequest
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func recommendations(limit: Int? = nil) async throws -> Recommendations {
    var request = MusicRecommendationRequest()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }
}

#if compiler(>=5.7)
public extension MusadoraKit {
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  static func recommendations(limit: Int? = nil) async throws -> MusicItemCollection<MusicPersonalRecommendation> {
    var request = MusicPersonalRecommendationsRequest()
    request.limit = limit
    let response = try await request.response()
    return response.recommendations
  }
}
#endif

/// A  request that your app uses to fetch recommendations from
/// the user's library, either default ones or based on identifiers.
public struct MusicRecommendationRequest {
  /// A limit for the number of items to return
  /// in the recommendation response.
  public var limit: Int?

  /// Creates a request to fetch default recommendations.
  public init() {}

  /// Creates a request to fetch a recommendation by using its identifier.
  public init(equalTo id: String) {
    ids = [id]
  }

  /// Creates a request to fetch one or more recommendations by using their identifiers.
  public init(memberOf ids: [String]) {
    self.ids = ids
  }

  /// Fetches recommendations based on the user’s library
  /// and purchase history for the given request.
  public func response() async throws -> MusicRecommendationResponse {
    let url = try recommendationEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let items = try decoder.decode(Recommendations.self, from: response.data)

    return MusicRecommendationResponse(items: items)
  }

  private var ids: [String]?
}

extension MusicRecommendationRequest {
  var recommendationEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem]?
      components.path = "me/recommendations"

      if let ids = ids {
        queryItems = [URLQueryItem(name: "ids", value: ids.joined(separator: ","))]
      }

      if let limit = limit {
        guard limit <= 30 else {
          throw MusadoraKitError.recommendationOverLimit(for: limit)
        }

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
