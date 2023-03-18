//
//  CatalogCleanEquivalents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation

public extension MusicItemCollection where MusicItemType: EquivalentRequestable {
  var clean: Self {
    get async throws {
      let path: EquivalentMusicItemType
      let storefront = try await MusicDataRequest.currentCountryCode
      var components = AppleMusicURLComponents()

      switch MusicItemType.self {
        case is Song.Type: path = .songs
        case is Album.Type: path = .albums
        case is MusicVideo.Type: path = .musicVideos
        default: throw NSError(domain: "Wrong equivalent music item type.", code: 0)
      }

      components.path = "catalog/\(storefront)/\(path.rawValue)"

      let ids = self.map { $0.id.rawValue }.joined(separator: ",")
      let filterEquivalentsQuery = URLQueryItem(name: "filter[equivalents]", value: ids)
      let restrictExplicitQuery = URLQueryItem(name: "restrict", value: "explicit")

      components.queryItems = [filterEquivalentsQuery, restrictExplicitQuery]

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      let request = MusicDataRequest(urlRequest: .init(url: url))
      let response = try await request.response()
      let items = try JSONDecoder().decode(MusicItemCollection<MusicItemType>.self, from: response.data)
      return items
    }
  }
}
