//
//  MusicCatalogRatingAddRequest.swift
//  MusicCatalogRatingAddRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func catalogSongAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicCatalogRatingAddRequest(for: id, item: .song, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogAlbumAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicCatalogRatingAddRequest(for: id, item: .album, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogPlaylistAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicCatalogRatingAddRequest(for: id, item: .playlist, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogMusicVideoAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicCatalogRatingAddRequest(for: id, item: .musicVideo, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func catalogStationAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicCatalogRatingAddRequest(for: id, item: .station, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }
}

public struct MusicCatalogRatingAddRequest {

  /// The type of the catalog item to rating for.
  private var type: CatalogRatingMusicItemType

  /// The unique identifier of the catalog item to add rating for.
  private var id: MusicItemID

  /// The rating of the catalog item.
  public var rating: RatingType

  /// Creates a request to fetch items using a filter that matches a specific value.
  public init(for id: MusicItemID, item type: CatalogRatingMusicItemType, rating: RatingType) {
    self.id = id
    self.type = type
    self.rating = rating
  }

  public func response() async throws -> RatingsResponse {
    let url = try catalogAddRatingsEndpointURL

    let rating = RatingRequest(value: rating)
    let data = try JSONEncoder().encode(rating)

    let request = MusicDataPutRequest(url: url, data: data)
    let response = try await request.response()
    return try JSONDecoder().decode(RatingsResponse.self, from: response.data)
  }
}

extension MusicCatalogRatingAddRequest {
  internal var catalogAddRatingsEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      components.path = "me/ratings/\(type.rawValue)/\(id.rawValue)"

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
