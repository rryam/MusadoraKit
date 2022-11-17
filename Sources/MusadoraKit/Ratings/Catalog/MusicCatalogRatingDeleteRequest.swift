//
//  MusicCatalogRatingDeleteRequest.swift
//  MusicCatalogRatingDeleteRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func catalogSongDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .song)
    let response = try await request.response()
    return response
  }

  static func catalogAlbumDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .album)
    let response = try await request.response()
    return response
  }

  static func catalogPlaylistDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .playlist)
    let response = try await request.response()
    return response
  }

  static func catalogMusicVideoDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .musicVideo)
    let response = try await request.response()
    return response
  }

  static func catalogStationDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicCatalogRatingDeleteRequest(for: id, item: .station)
    let response = try await request.response()
    return response
  }
}

public struct MusicCatalogRatingDeleteRequest {

  private var type: CatalogRatingMusicItemType
  private var id: MusicItemID

  /// Creates a request to fetch items using a filter that matches
  /// a specific value.
  public init(for id: MusicItemID, item type: CatalogRatingMusicItemType) {
    self.id = id
    self.type = type
  }

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
