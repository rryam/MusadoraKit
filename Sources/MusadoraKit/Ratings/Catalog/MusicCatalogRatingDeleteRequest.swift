//
//  MusicCatalogRatingDeleteRequest.swift
//  MusicCatalogRatingDeleteRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func deleteCatalogSongRating(for id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .song)
    let response = try await request.response()
    return response
  }

  static func deleteCatalogAlbumRating(for id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .album)
    let response = try await request.response()
    return response
  }

  static func deleteCatalogPlaylistRating(for id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .playlist)
    let response = try await request.response()
    return response
  }

  static func deleteCatalogMusicVideoRating(for id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .musicVideo)
    let response = try await request.response()
    return response
  }

  static func deleteCatalogStationRating(for id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .station)
    let response = try await request.response()
    return response
  }
}

/// A request that your app uses to delete ratings for albums, songs,
/// playlists, music videos, and stations for content in the Apple Music catalog.
public struct MusicCatalogRatingDeleteRequest {

  private var type: CatalogRatingMusicItemType
  private var id: MusicItemID

  /// Creates a request to delete the rating for the unique identifier of the given catalog item.
  /// - Parameters:
  ///   - id: The unique identifier of the catalog item.
  ///   - type: The type of the catalog item. Possible values: `song`, `album`, `playlist`, `musicVideo`, `station`.
  public init(for id: MusicItemID, item type: CatalogRatingMusicItemType) {
    self.id = id
    self.type = type
  }

  /// Deletes the rating of the given catalog item
  /// that matches the unique identifier for the request.
  public func response() async throws -> Bool {
    let url = try catalogDeleteRatingsEndpointURL
    let request = MusicDataDeleteRequest(url: url)
    let response = try await request.response()
    // 204 EmptyBodyResponse - The modification was successful, but there’s no content in the response.
    return response.urlResponse.statusCode == 204
  }
}

extension MusicCatalogRatingDeleteRequest {
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
