//
//  LibraryCatalog.swift
//  LibraryCatalog
//
//  Created by Rudrank Riyam on 10/05/22.
//

import Foundation


public extension FilterableLibraryItem {
  var catalog: Self {
    get async throws {
      let path: LibraryMusicItemType
      var components = AppleMusicURLComponents()

      switch self {
        case is Song: path = .songs
        case is Album: path = .albums
        case is Artist: path = .artists
        case is MusicVideo: path = .musicVideos
        case is Playlist: path = .playlists
        default: throw NSError(domain: "Wrong library music item type.", code: 0)
      }

      components.path = "me/library/\(path.rawValue)/\(id.rawValue)/catalog"

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
