//
//  MCatalogRatingAddRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// A request that your app uses to add ratings for music items in the Apple Music catalog.
///
/// This structure allows users to rate catalog items such as songs, albums, playlists,
/// music videos, and stations with either a like or dislike.
///
/// Example usage:
/// ```swift
/// let request = MCatalogRatingAddRequest(
///     with: "1234567890",
///     item: .song,
///     rating: .like
/// )
///
/// do {
///     let response = try await request.response()
///     print("Rating added successfully")
/// } catch {
///     print("Failed to add rating: \(error)")
/// }
/// ```
struct MCatalogRatingAddRequest {
  /// The type of music item being rated.
  private var type: CatalogRatingMusicItemType

  /// The unique identifier of the item being rated.
  private var id: MusicItemID

  /// The rating (like/dislike) to be applied to the item.
  var rating: RatingType

  /// Creates a request to get the rating for the unique identifier of the given library item.
  /// - Parameters:
  ///   - id: The unique identifier of the catalog item.
  ///   - type: The type of the catalog item. Possible values: `song`, `album`, `playlist`, `musicVideo`, `station`.
  ///   - rating: The rating to add for the given catalog item. Possible values: `like`, `dislike`.
  init(with id: MusicItemID, item type: CatalogRatingMusicItemType, rating: RatingType) {
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

