//
//  MusicCatalogRatingRequest.swift
//  MusicCatalogRatingRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func getCatalogAlbumRating(for id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .album)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw RatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func getCatalogAlbumsRating(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .song)
    let response = try await request.response()
    return response.data
  }

  static func getCatalogSongRating(for id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .song)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw RatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func getCatalogSongsRating(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .song)
    let response = try await request.response()
    return response.data
  }

  static func getCatalogMusicVideoRating(for id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .musicVideo)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw RatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func getCatalogMusicVideosRating(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .musicVideo)
    let response = try await request.response()
    return response.data
  }

  static func getCatalogPlaylistRating(for id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .playlist)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw RatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func getCatalogPlaylistsRating(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .playlist)
    let response = try await request.response()
    return response.data
  }

  static func getCatalogStationRating(for id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .station)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw RatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func getCatalogStationsRating(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .station)
    let response = try await request.response()
    return response.data
  }
}

/// A request that your app uses to get ratings for albums, songs,
/// playlists, music videos, and stations for content in the Apple Music catalog.
public struct MusicCatalogRatingRequest {

  private var type: CatalogRatingMusicItemType
  private var ids: [MusicItemID]

  /// Creates a request to get ratings for the unique identifiers of the given catalog item.
  /// - Parameters:
  ///   - ids: The unique identifiers of the catalog item.
  ///   - type: The type of the catalog item. Possible values: `song`, `album`, `playlist`, `musicVideo`, `station`.
  public init(for ids: [MusicItemID], item type: CatalogRatingMusicItemType) {
    self.type = type
    self.ids = ids
  }

  /// Creates a request to get the rating for the unique identifier of the given catalog item.
  /// - Parameters:
  ///   - id: The unique identifier of the catalog item.
  ///   - type: The type of the catalog item. Possible values: `song`, `album`, `playlist`, `musicVideo`, `station`.
  public init(for id: MusicItemID, item type: CatalogRatingMusicItemType) {
    self.type = type
    self.ids = [id]
  }

  /// Fetches the given rating(s) of the given catalog item
  /// that matches the unique identifier(s) for the request.
  public func response() async throws -> RatingsResponse {
    let url = try catalogRatingsEndpointURL
    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()
    return try JSONDecoder().decode(RatingsResponse.self, from: response.data)
  }
}

extension MusicCatalogRatingRequest {
  internal var catalogRatingsEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem]?
      components.path = "me/ratings/\(type.rawValue)"

      let ids = ids.map { $0.rawValue }.joined(separator: ",")
      queryItems = [URLQueryItem(name: "ids", value: ids)]

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
