//
//  CatalogEquivalent.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation

public extension EquivalentRequestable {
  func equivalent(for targetStorefront: String) async throws -> Self {
    let path = try EquivalentMusicItemType.path(for: Self.self)

    let url = try equivalentURL(storefront: targetStorefront, path: path)
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(MusicItemCollection<Self>.self, from: response.data)

    guard let item = items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return item
  }

  internal func equivalentURL(storefront: String, path: EquivalentMusicItemType) throws -> URL {
    var components = AppleMusicURLComponents()

    components.path = "catalog/\(storefront)/\(path.rawValue)"
    components.queryItems = [URLQueryItem(name: "filter[equivalents]", value: id.rawValue)]

    guard let url = components.url else {
      throw URLError(.badURL)
    }
    return url
  }
}
