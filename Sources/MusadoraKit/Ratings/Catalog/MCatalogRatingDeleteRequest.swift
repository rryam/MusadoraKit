//
//  MCatalogRatingDeleteRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// A request that your app uses to delete ratings for albums, songs,
/// playlists, music videos, and stations for content in the Apple Music catalog.
public struct MCatalogRatingDeleteRequest {
  private var type: CatalogRatingMusicItemType
  private var id: MusicItemID

  /// Creates a request to delete the rating for the unique identifier of the given catalog item.
  /// - Parameters:
  ///   - id: The unique identifier of the catalog item.
  ///   - type: The type of the catalog item. Possible values: `song`, `album`, `playlist`, `musicVideo`, `station`.
  public init(with id: MusicItemID, item type: CatalogRatingMusicItemType) {
    self.id = id
    self.type = type
  }

  /// Deletes the rating of the given catalog item
  /// that matches the unique identifier for the request.
  public func response() async throws -> Bool {
    let url = try catalogDeleteRatingsEndpointURL
    let request = MDataDeleteRequest(url: url)
    let response = try await request.response()
    // 204 EmptyBodyResponse - The modification was successful, but there’s no content in the response.
    return response.urlResponse.statusCode == 204
  }
}

extension MCatalogRatingDeleteRequest {
  internal var catalogDeleteRatingsEndpointURL: URL {
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
