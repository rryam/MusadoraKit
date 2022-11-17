//
//  MusicCatalogRatingRequest.swift
//  MusicCatalogRatingRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func catalogAlbumRating(id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .album)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogAlbumsRating(ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .song)
    let response = try await request.response()
    return response.data
  }

  static func catalogSongRating(id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .song)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogSongsRating(ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .song)
    let response = try await request.response()
    return response.data
  }

  static func catalogMusicVideoRating(id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .musicVideo)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogMusicVideosRating(ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .musicVideo)
    let response = try await request.response()
    return response.data
  }

  static func catalogPlaylistRating(id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .playlist)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogPlaylistsRating(ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .playlist)
    let response = try await request.response()
    return response.data
  }

  static func catalogStationRating(for id: MusicItemID) async throws -> Rating {
    let request = MusicCatalogRatingRequest(for: id, item: .station)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogStationsRating(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicCatalogRatingRequest(for: ids, item: .station)
    let response = try await request.response()
    return response.data
  }
}

/// A request that your app uses to get ratings for albums, songs,
/// playlists, music videos, and stations for content in the Apple Music catalog.
public struct MusicCatalogRatingRequest {

  /// Creates a request to fetch items using a filter that matches a specific value.
  public init(for ids: [MusicItemID], item type: CatalogRatingMusicItemType) {
    self.type = type
    self.ids = ids
  }

  /// Creates a request to fetch items using a filter that matches
  /// any value from an array of possible values.
  public init(for id: MusicItemID, item type: CatalogRatingMusicItemType) {
    self.type = type
    self.ids = [id]
  }

  public func response() async throws -> RatingsResponse {
    let url = try catalogRatingsEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    return try JSONDecoder().decode(RatingsResponse.self, from: response.data)
  }

  private var type: CatalogRatingMusicItemType
  private var ids: [MusicItemID]
}

extension MusicCatalogRatingRequest {
  internal var catalogRatingsEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem]?
      components.path = "me/ratings/\(type.rawValue)"

      queryItems = [URLQueryItem(name: "ids", value: ids.map { $0.rawValue }.joined(separator: ","))]

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
