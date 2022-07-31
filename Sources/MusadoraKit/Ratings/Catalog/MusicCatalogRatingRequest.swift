//
//  MusicCatalogRatingRequest.swift
//  MusicCatalogRatingRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func catalogAlbumRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicCatalogRatingRequest<Album>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogAlbumsRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicCatalogRatingRequest<Album>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }

  static func catalogSongRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicCatalogRatingRequest<Song>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogSongsRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicCatalogRatingRequest<Song>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }

  static func catalogMusicVideoRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicCatalogRatingRequest<MusicVideo>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogMusicVideosRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicCatalogRatingRequest<MusicVideo>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }

  static func catalogPlaylistRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicCatalogRatingRequest<Playlist>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogPlaylistsRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicCatalogRatingRequest<Playlist>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }

  static func catalogStationRating(id: MusicItemID) async throws -> Ratings {
    let request = MusicCatalogRatingRequest<Station>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let rating = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogStationsRating(id: [MusicItemID]) async throws -> [Ratings] {
    let request = MusicCatalogRatingRequest<Station>(matching: \.id, memberOf: id)
    let response = try await request.response()
    return response.items
  }
}

/// A request that your app uses to fetch and set ratings for albums, songs,
/// playlists, music videos, and stations for content in the Apple Music catalog.
public struct MusicCatalogRatingRequest<MusicItemType> where MusicItemType: MusicItem, MusicItemType: Decodable {
  /// Creates a request to fetch items using a filter that matches a specific value.
  public init<Value>(matching _: KeyPath<MusicItemType.FilterableCatalogRatingType, Value>, equalTo value: Value) where MusicItemType: FilterableCatalogRatingItem {
    setType()

    if let id = value as? MusicItemID {
      ids = [id.rawValue]
    }
  }

  /// Creates a request to fetch items using a filter that matches
  /// any value from an array of possible values.
  public init<Value>(matching _: KeyPath<MusicItemType.FilterableCatalogRatingType, Value>, memberOf values: [Value]) where MusicItemType: FilterableCatalogRatingItem {
    setType()

    if let ids = values as? [MusicItemID] {
      self.ids = ids.map { $0.rawValue }
    }
  }

  public func response() async throws -> MusicRatingResponse {
    let url = try catalogRatingsEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(RatingsResponse.self, from: response.data)
    return MusicRatingResponse(items: items.data)
  }

  private var type: CatalogRatingMusicItemType?
  private var ids: [String] = []
}

extension MusicCatalogRatingRequest {
  private mutating func setType() {
    switch MusicItemType.self {
    case is Song.Type: type = .songs
    case is Album.Type: type = .albums
    case is Station.Type: type = .stations
    case is MusicVideo.Type: type = .musicVideos
    case is Playlist.Type: type = .playlists
    default: type = nil
    }
  }

  internal var catalogRatingsEndpointURL: URL {
    get throws {
      guard let type = type else {
        throw RatingsError.typeMissing
      }

      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem]?
      components.path = "me/ratings/\(type.rawValue)"

      if ids.isEmpty {
        throw RatingsError.idMissing
      } else {
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
