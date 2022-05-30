//
//  MusicLibraryRatingRequest.swift
//
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func librarySongRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicLibraryRatingRequest<Song>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func librarySongsRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicLibraryRatingRequest<Song>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }

  static func libraryMusicVideoRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicLibraryRatingRequest<MusicVideo>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryMusicVideosRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicLibraryRatingRequest<MusicVideo>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }

  static func libraryPlaylistRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicLibraryRatingRequest<Playlist>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryPlaylistsRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicLibraryRatingRequest<Playlist>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }

  static func libraryAlbumRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicLibraryRatingRequest<Album>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryAlbumsRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicLibraryRatingRequest<Album>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }
}

/// A request that your app uses to fetch and set
/// ratings for albums, songs, playlists, music videos, and stations
/// for content in the user's iCloud library.
public struct MusicLibraryRatingRequest<MusicItemType> where MusicItemType: MusicItem, MusicItemType: Decodable {
  /// Creates a request to fetch items using a filter that matches
  /// a specific value.
  public init<Value>(matching _: KeyPath<MusicItemType.FilterableLibraryRatingType, Value>, equalTo value: Value) where MusicItemType: FilterableLibraryRatingItem {
    setType()

    if let id = value as? MusicItemID {
      ids = [id.rawValue]
    }
  }

  /// Creates a request to fetch items using a filter that matches
  /// any value from an array of possible values.
  public init<Value>(matching _: KeyPath<MusicItemType.FilterableLibraryRatingType, Value>, memberOf values: [Value]) where MusicItemType: FilterableLibraryRatingItem {
    setType()

    if let ids = values as? [MusicItemID] {
      self.ids = ids.map { $0.rawValue }
    }
  }

  public func response() async throws -> MusicRatingResponse {
    let url = try libraryRatingsEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(RatingsResponse.self, from: response.data)
    return MusicRatingResponse(items: items.data)
  }

  private var type: LibraryRatingMusicItemType?
  private var ids: [String]?
}

extension MusicLibraryRatingRequest {
  private mutating func setType() {
    switch MusicItemType.self {
    case is Song.Type: type = .songs
    case is Album.Type: type = .albums
    case is MusicVideo.Type: type = .musicVideos
    case is Playlist.Type: type = .playlists
    default: type = nil
    }
  }

  internal var libraryRatingsEndpointURL: URL {
    get throws {
      guard let type = type else { throw URLError(.badURL) }

      var components = URLComponents()
      var queryItems: [URLQueryItem]?

      components.scheme = "https"
      components.host = "api.music.apple.com"
      components.path = "/v1/me/ratings/"
      components.path += type.rawValue

      if let ids = ids {
        queryItems = [URLQueryItem(name: "ids", value: ids.joined(separator: ","))]
      }

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
