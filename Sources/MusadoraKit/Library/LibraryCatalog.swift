//
//  LibraryCatalog.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/05/22.
//

import Foundation

public extension FilterableLibraryItem {

  /// The catalog version of the library item.
  var catalog: Self {
    get async throws {
      let path = try LibraryMusicItemType.path(for: Self.self)
      let url = try catalogURL(path: path)
      let request = MusicDataRequest(urlRequest: URLRequest(url: url))
      let response = try await request.response()
      let items = try JSONDecoder().decode(MusicItemCollection<Self>.self, from: response.data)

      guard let item = items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return item
    }
  }

  internal func catalogURL(path: LibraryMusicItemType) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "me/library/\(path.rawValue)/\(id.rawValue)/catalog"

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
