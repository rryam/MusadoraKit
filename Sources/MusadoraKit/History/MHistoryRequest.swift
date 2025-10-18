//
//  MHistoryRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

/// A  request that your app uses to fetch historical information about
/// the songs and stations the user played recently.
struct MHistoryRequest {
  /// A limit for the number of items to return
  /// in the history response.
  var limit: Int?

  /// An offet for the request.
  var offset: Int?

  /// Endpoints to fetch historical information about the songs and stations the user played recently.
  /// Possible values: `heavyRotation`, `recentlyAdded` and `recentlyPlayed`.
  var endpoint: MHistoryEndpoints

  /// Creates a request to fetch historical data based on the history endpoint.
  init(for endpoint: MHistoryEndpoints) {
    self.endpoint = endpoint

    switch self.endpoint {
    case .heavyRotation, .recentlyPlayed, .recentlyPlayedStations:
      maximumLimit = 10
    case .recentlyAdded:
      maximumLimit = 25
    case .recentlyPlayedTracks:
      maximumLimit = 30
    }
  }

  /// Fetches historical information based on the user’s history for the given request.
  func response() async throws -> MHistoryResponse {
    let items: UserMusicItems
    let url = try historyEndpointURL
    let decoder = JSONDecoder()

    if let userToken = MusadoraKit.userToken {
      let request = MUserRequest(urlRequest: .init(url: url), userToken: userToken)
      let data = try await request.response()
      let baseItems = try decoder.decode(UserMusicItems.self, from: data)
      items = try await baseItems.collectingAll(upTo: limit)
    } else {
      let request = MusicDataRequest(urlRequest: URLRequest(url: url))
      let response = try await request.response()
      let baseItems = try decoder.decode(UserMusicItems.self, from: response.data)
      items = try await baseItems.collectingAll(upTo: limit)
    }

    return MHistoryResponse(items: items)
  }

  /// Maximum limit of the number of resources for each request.
  internal var maximumLimit: Int = 0
}

extension MHistoryRequest {
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
