//
//  MLibraryResourceRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

/// A request that your app uses to fetch items from the user's library
/// using a filter.
struct MLibraryResourceRequest<MusicItemType: MusicItem & Codable> {
  /// A limit for the number of items to return
  /// in the catalog resource response.
  var limit: Int?

  /// Creates a request to fetch all the items in alphabetical order.
  init() {
    setType()
  }

  /// Creates a request to fetch items using a filter that matches
  /// a specific value.
  init<Value>(matching _: KeyPath<MusicItemType.FilterLibraryType, Value>, equalTo value: Value) where MusicItemType: FilterableLibraryItem {
    setType()

    if let id = value as? MusicItemID {
      ids = [id.rawValue]
    }
  }

  /// Creates a request to fetch items using a filter that matches
  /// any value from an array of possible values.
  init<Value>(matching _: KeyPath<MusicItemType.FilterLibraryType, Value>, memberOf values: [Value]) where MusicItemType: FilterableLibraryItem {
    setType()

    if let ids = values as? [MusicItemID] {
      self.ids = ids.map { $0.rawValue }
    }
  }

  /// Fetches items from the user's library that match a specific filter.
  func response() async throws -> MLibraryResourceResponse<MusicItemType> {
    let url = try libraryEndpointURL
    let decoder = JSONDecoder()

    if let userToken = MusadoraKit.userToken {
      let request = MUserRequest(urlRequest: .init(url: url), userToken: userToken)
      let data = try await request.response()
      let items = try decoder.decode(MusicItemCollection<MusicItemType>.self, from: data)
      return MLibraryResourceResponse(items: items)
    } else {
      let request = MusicDataRequest(urlRequest: URLRequest(url: url))
      let response = try await request.response()
      let items = try decoder.decode(MusicItemCollection<MusicItemType>.self, from: response.data)
      return MLibraryResourceResponse(items: items)
    }
  }

  private var type: LibraryMusicItemType?
  private var ids: [String]?
}

extension MLibraryResourceRequest {
  private mutating func setType() {
    switch MusicItemType.self {
      case is Song.Type: type = .songs
      case is Album.Type: type = .albums
      case is Artist.Type: type = .artists
      case is MusicVideo.Type: type = .musicVideos
      case is Playlist.Type: type = .playlists
      default: type = nil
    }
  }

  internal var libraryEndpointURL: URL {
    get throws {
      guard let type = type else { throw URLError(.badURL) }

      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []

      components.path = "me/library/\(type.rawValue)"

      if let ids = ids {
        queryItems += [URLQueryItem(name: "ids", value: ids.joined(separator: ","))]
      }

      if let limit = limit {
        queryItems += [URLQueryItem(name: "limit", value: "\(limit)")]
      }

      queryItems += [
        URLQueryItem(name: "fields[albums]", value: "artistName,artistUrl,artwork,contentRating,editorialArtwork,name,playParams,releaseDate,url"),
        URLQueryItem(name: "fields[artists]", value: "name,url"),
        URLQueryItem(name: "includeOnly", value: "catalog,artists"),
        URLQueryItem(name: "include[albums]", value: "artists"),
        URLQueryItem(name: "include[library-albums]", value: "artists"),
      ]

      components.queryItems = queryItems

      print("MLibraryResourceRequest components", components)

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      return url
    }
  }
}
