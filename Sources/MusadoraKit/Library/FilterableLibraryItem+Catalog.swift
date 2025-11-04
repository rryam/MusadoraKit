// 
//  LibraryCatalog.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/05/22.
//

import Foundation

public extension FilterableLibraryItem {
  /// The catalog version of the library item.
  ///
  /// This property fetches the full catalog equivalent of a library resource from the Apple Music API.
  /// Library items contain limited metadata, while catalog items include complete information
  /// such as artwork, relationships, and additional attributes.
  ///
  /// - Returns: The catalog version of the library item with full metadata and relationships.
  var catalog: Self {
    get async throws {
      let path = try LibraryMusicItemType.path(for: Self.self)
      let url = try catalogURL(path: path)
      let decoder = JSONDecoder()

      let data: Data
      if let userToken = MusadoraKit.userToken {
        let request = MusicUserRequest(urlRequest: .init(url: url), userToken: userToken)
        data = try await request.response()
      } else {
        let request = MusicDataRequest(urlRequest: URLRequest(url: url))
        let response = try await request.response()
        data = response.data
      }

      return try decodeCatalogItem(from: data, decoder: decoder)
    }
  }

  private func decodeCatalogItem(from data: Data, decoder: JSONDecoder) throws -> Self {
    let items = try decoder.decode(MusicItemCollection<Self>.self, from: data)

        guard let item = items.first else {
          throw MusadoraKitError.notFound(for: id.rawValue)
        }

        return item
  }

  /// Creates the URL for fetching the catalog equivalent of a library resource.
  ///
  /// - Parameter path: The library music item type (e.g., "songs", "albums").
  /// - Returns: A URL pointing to the Apple Music API endpoint `/me/library/{type}/{id}/catalog`.
  internal func catalogURL(path: LibraryMusicItemType) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "me/library/\(path.rawValue)/\(id.rawValue)/catalog"

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
