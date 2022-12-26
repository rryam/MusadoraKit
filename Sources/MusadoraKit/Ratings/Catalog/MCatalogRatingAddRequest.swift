//
//  MCatalogRatingAddRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

/// A request that your app uses to add ratings for albums, songs,
/// playlists, music videos, and stations for content in the Apple Music catalog.
struct MCatalogRatingAddRequest {

  private var type: CatalogRatingMusicItemType
  private var id: MusicItemID

  /// The rating of the catalog item.
  var rating: RatingType

  /// Creates a request to get the rating for the unique identifier of the given library item.
  /// - Parameters:
  ///   - id: The unique identifier of the catalog item.
  ///   - type: The type of the catalog item. Possible values: `song`, `album`, `playlist`, `musicVideo`, `station`.
  ///   - rating: The rating to add for the given catalog item. Possible values: `like`, `dislike`.
  init(for id: MusicItemID, item type: CatalogRatingMusicItemType, rating: RatingType) {
    self.id = id
    self.type = type
    self.rating = rating
  }

  /// Adds the given rating for the given catalog item
  /// that matches the unique identifier(s) for the request.
  func response() async throws -> RatingsResponse {
    let url = try catalogAddRatingsEndpointURL

    let rating = RatingRequest(value: rating)
    let data = try JSONEncoder().encode(rating)

    let request = MDataPutRequest(url: url, data: data)
    let response = try await request.response()
    return try JSONDecoder().decode(RatingsResponse.self, from: response.data)
  }
}

extension MCatalogRatingAddRequest {
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


enum MRatingError: Error, Equatable {
  case notFound(for: String)
}

extension MRatingError: CustomStringConvertible {
  var description: String {
    switch self {
      case let .notFound(id):
        return "No rating be found for \(id)."
    }
  }
}
