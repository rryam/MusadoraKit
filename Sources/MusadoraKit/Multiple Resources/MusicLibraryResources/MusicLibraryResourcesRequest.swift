//
//  MusicLibraryResourcesRequest.swift
//  MusicLibraryResourcesRequest
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation
import MusicKit

/// A request that your app uses to fetch multiple resources from the user's library
/// using their identifiers.
public struct MusicLibraryResourcesRequest {
  private var types: [MusicLibraryResourcesType.Key: [MusicItemID]]

  /// Creates a request to fetch multiple resources from the user's library using their identifiers.
  public init(types: [MusicLibraryResourcesType.Key: [MusicItemID]]) {
    self.types = types
  }

  /// Fetches different library music items based on the types for the given request.
  public func response() async throws -> MusicLibraryResourcesResponse {
    let url = try multipleLibraryResourcesEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(MusicLibraryResourcesTypes.self, from: response.data)
    return MusicLibraryResourcesResponse(items: items)
  }
}

extension MusicLibraryResourcesRequest {
  private var multipleLibraryResourcesEndpointURL: URL {
    get throws {
      var components = URLComponents()
      var queryItems: [URLQueryItem] = []

      components.scheme = "https"
      components.host = "api.music.apple.com"
      components.path = "/v1/me/library"

      for (key, value) in types {
        let values = value.map { $0.rawValue }.joined(separator: ",")
        queryItems.append(URLQueryItem(name: key.type, value: values))
      }

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
