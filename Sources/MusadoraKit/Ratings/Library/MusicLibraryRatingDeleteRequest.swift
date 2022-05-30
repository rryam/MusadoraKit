//
//  MusicLibraryRatingDeleteRequest.swift
//  MusicLibraryRatingDeleteRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public struct MusicLibraryRatingDeleteRequest<MusicItemType> where MusicItemType: MusicItem, MusicItemType: Decodable {
  /// Creates a request to fetch items using a filter that matches
  /// a specific value.
  public init<Value>(matching _: KeyPath<MusicItemType.FilterableLibraryRatingType, Value>, equalTo value: Value) where MusicItemType: FilterableLibraryRatingItem {
    setType()

    if let id = value as? MusicItemID {
      self.id = id.rawValue
    }
  }

  public func response() async throws {
    let url = try libraryDeleteRatingsEndpointURL
    let request = MusicDataDeleteRequest(url: url)
    _ = try await request.response()
  }

  private var type: LibraryRatingMusicItemType?
  private var id: String?
}

extension MusicLibraryRatingDeleteRequest {
  private mutating func setType() {
    switch MusicItemType.self {
    case is Song.Type: type = .songs
    case is Album.Type: type = .albums
    case is MusicVideo.Type: type = .musicVideos
    case is Playlist.Type: type = .playlists
    default: type = nil
    }
  }

  internal var libraryDeleteRatingsEndpointURL: URL {
    get throws {
      guard let type = type else { throw URLError(.badURL) }

      var components = URLComponents()

      components.scheme = "https"
      components.host = "api.music.apple.com"
      components.path = "/v1/me/ratings/"

      if let id = id {
        components.path += "\(type.rawValue)/\(id)"
      }

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
