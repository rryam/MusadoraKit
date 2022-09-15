//
//  MusicHistoryRequest.swift
//  MusicHistoryRequest
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

/// A  request that your app uses to fetch historical information about
/// the songs and stations the user played recently.
public struct MusicHistoryRequest {
  /// A limit for the number of items to return
  /// in the history response.
  public var limit: Int?

  /// An offet for the request.
  public var offset: Int?

  /// Endpoints to fetch historical information about the songs and stations the user played recently.
  /// Possible values: `heavyRotation`, `recentlyAdded` and `recentlyPlayed`.
  public var endpoint: MusicHistoryEndpoints

  /// Creates a request to fetch historical data based on the history endpoint.
  public init(for endpoint: MusicHistoryEndpoints) {
    self.endpoint = endpoint

    switch self.endpoint {
      case .heavyRotation, .recentlyPlayed, .recentlyPlayedStations: maximumLimit = 10
      case .recentlyAdded: maximumLimit = 25
      case .recentlyPlayedTracks: maximumLimit = 30
    }
  }

  /// Fetches historical information based on the user’s history for the given request.
  public func response() async throws -> MusicHistoryResponse {
    let url = try historyEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(UserMusicItems.self, from: response.data)
    return MusicHistoryResponse(items: items)
  }

  /// Maximum limit of the number of resources for each request.
  internal var maximumLimit: Int = 0
}

extension MusicHistoryRequest {
  internal var historyEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []

      components.path = "me/\(endpoint.path)"

      if endpoint == .recentlyPlayed {
        queryItems.append(URLQueryItem(name: "with", value: "library"))
      }

      if let limit = limit {
        guard limit <= maximumLimit else {
          throw MusadoraKitError.historyOverLimit(limit: maximumLimit, overLimit: limit)
        }

        queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
      }

      if let offset = offset {
        queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
      }

      if !queryItems.isEmpty {
        components.queryItems = queryItems
      }

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
