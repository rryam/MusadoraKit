//
//  MusicCatalogResourcesRequest.swift
//  MusicCatalogResourcesRequest
//
//  Created by Rudrank Riyam on 22/04/22.
//

import Foundation

/// A request that your app uses to fetch multiple resources from the Apple Music catalog
/// using their identifiers.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public struct MusicCatalogResourcesRequest {
  private var types: CatalogResourceIdentifiers

  /// Creates a request to fetch multiple resources from the Apple Music catalog using their identifiers.
  public init(types: CatalogResourceIdentifiers) {
    self.types = types
  }

  /// Fetches different catalog music items based on the types for the given request.
  public func response() async throws -> MusicCatalogResourcesResponse {
    let url = try await multipleCatalogResourcesEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(MusicCatalogResourcesTypes.self, from: response.data)
    return MusicCatalogResourcesResponse(items: items)
  }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogResourcesRequest {
  private var multipleCatalogResourcesEndpointURL: URL {
    get async throws {
      let storefront = try await MusicDataRequest.currentCountryCode

      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []
      components.path = "catalog/\(storefront)"

      for (key, value) in types {
        let values = value.map { $0.rawValue }.joined(separator: ",")
        queryItems.append(URLQueryItem(name: key.type, value: values))
      }

      components.queryItems = queryItems.isEmpty ? nil : queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
