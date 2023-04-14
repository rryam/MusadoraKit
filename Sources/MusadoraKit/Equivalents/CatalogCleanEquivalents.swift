//
//  CatalogCleanEquivalents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation

public extension MusicItemCollection where MusicItemType: EquivalentRequestable {

  /// Returns a clean version of the music items.
  ///
  /// Example usage:
  ///
  ///     let albums: MusicItemCollection<Album> = ...
  ///     let cleanAlbums = try await albums.clean
  var clean: Self {
    get async throws {
      let path = try EquivalentMusicItemType.path(for: MusicItemType.self)
      let storefront = try await MusicDataRequest.currentCountryCode

      let url = try cleanEquivalentsURL(storefront: storefront, path: path)
      let request = MusicDataRequest(urlRequest: .init(url: url))
      let response = try await request.response()
      let items = try JSONDecoder().decode(MusicItemCollection<MusicItemType>.self, from: response.data)
      return items
    }
  }

  internal func cleanEquivalentsURL(storefront: String, path: EquivalentMusicItemType) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(storefront)/\(path.rawValue)"

    let ids = self.map { $0.id.rawValue }.joined(separator: ",")
    let filterEquivalentsQuery = URLQueryItem(name: "filter[equivalents]", value: ids)
    let restrictExplicitQuery = URLQueryItem(name: "restrict", value: "explicit")

    components.queryItems = [filterEquivalentsQuery, restrictExplicitQuery]

    guard let url = components.url else {
      throw URLError(.badURL)
    }
    return url
  }
}
