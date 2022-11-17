//
//  MusicLibraryRatingDeleteRequest.swift
//  MusicLibraryRatingDeleteRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func librarySongDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicLibraryRatingDeleteRequest(for: id, item: .song)
    let response = try await request.response()
    return response
  }

  static func libraryAlbumDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicLibraryRatingDeleteRequest(for: id, item: .album)
    let response = try await request.response()
    return response
  }

  static func libraryPlaylistDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicLibraryRatingDeleteRequest(for: id, item: .playlist)
    let response = try await request.response()
    return response
  }

  static func libraryMusicVideoDeleteRating(id: MusicItemID) async throws -> Bool {
    let request = MusicLibraryRatingDeleteRequest(for: id, item: .musicVideo)
    let response = try await request.response()
    return response
  }
}

public struct MusicLibraryRatingDeleteRequest {

  /// The type of the library item to
  /// delete rating for.
  private var type: LibraryRatingMusicItemType

  /// The unique identifier of the library item to
  /// delete rating for.
  private var id: MusicItemID

  /// Creates a request to fetch items using a filter that matches
  /// a specific value.
  public init(for id: MusicItemID, item type: LibraryRatingMusicItemType) {
    self.id = id
    self.type = type
  }

  public func response() async throws -> Bool {
    let url = try libraryDeleteRatingsEndpointURL
    let request = MusicDataDeleteRequest(url: url)
    let response = try await request.response()
    // 204 EmptyBodyResponse - The modification was successful, but there’s no content in the response.
    return response.urlResponse.statusCode == 204
  }
}

extension MusicLibraryRatingDeleteRequest {
  internal var libraryDeleteRatingsEndpointURL: URL {
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
