//
//  CatalogCleanEquivalent.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation

public extension EquivalentRequestable {
  var clean: Self {
    get async throws {
      let path: EquivalentMusicItemType
      let storefront = try await MusicDataRequest.currentCountryCode
      var components = AppleMusicURLComponents()

      switch self {
        case is Song: path = .songs
        case is Album: path = .albums
        case is MusicVideo: path = .musicVideos
        default: throw NSError(domain: "Wrong equivalent music item type.", code: 0)
      }

      components.path = "catalog/\(storefront)/\(path.rawValue)"

      let filterEquivalentsQuery = URLQueryItem(name: "filter[equivalents]", value: id.rawValue)
      let restrictExplicitQuery = URLQueryItem(name: "restrict", value: "explicit")
      components.queryItems = [filterEquivalentsQuery, restrictExplicitQuery]

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      let request = MusicDataRequest(urlRequest: .init(url: url))
      let response = try await request.response()
      let items = try JSONDecoder().decode(MusicItemCollection<Self>.self, from: response.data)

      guard let item = items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return item
    }
  }
}
