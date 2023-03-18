//
//  CatalogEquivalent.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation

public extension EquivalentRequestable {
  func equivalent(for targetStorefront: String) async throws -> Self {
    let path: EquivalentMusicItemType
    var components = AppleMusicURLComponents()

    switch self {
      case is Song: path = .songs
      case is Album: path = .albums
      case is MusicVideo: path = .musicVideos
      default: throw NSError(domain: "Wrong equivalent music item type.", code: 0)
    }

    components.path = "catalog/\(targetStorefront)/\(path.rawValue)"
    components.queryItems = [URLQueryItem(name: "filter[equivalents]", value: id.rawValue)]

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
