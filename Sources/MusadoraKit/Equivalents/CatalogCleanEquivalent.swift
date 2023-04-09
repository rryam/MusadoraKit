//
//  CatalogCleanEquivalent.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation

public extension EquivalentRequestable {
  /// Returns a clean version of the music item
  ///
  /// Example usage:
  ///
  ///     let album = try await Album(id: "123").clean
  ///     let song = try await Song(id: "456").clean
  ///     let musicVideo = try await MusicVideo(id: "789").clean
  ///
  var clean: Self {
    get async throws {
      let path = try EquivalentMusicItemType.path(for: Self.self)
      let storefront = try await MusicDataRequest.currentCountryCode

      let url = try cleanEquivalentURL(storefront: storefront, path: path)
      let request = MusicDataRequest(urlRequest: .init(url: url))
      let response = try await request.response()
      let items = try JSONDecoder().decode(MusicItemCollection<Self>.self, from: response.data)

      guard let item = items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return item
    }
  }

  internal func cleanEquivalentURL(storefront: String, path: EquivalentMusicItemType) throws -> URL {
    var components = AppleMusicURLComponents()

    components.path = "catalog/\(storefront)/\(path.rawValue)"

    let filterEquivalentsQuery = URLQueryItem(name: "filter[equivalents]", value: id.rawValue)
    let restrictExplicitQuery = URLQueryItem(name: "restrict", value: "explicit")
    components.queryItems = [filterEquivalentsQuery, restrictExplicitQuery]

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
