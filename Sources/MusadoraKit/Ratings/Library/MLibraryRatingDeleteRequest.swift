//
//  MusicLibraryRatingDeleteRequest.swift
//  MusicLibraryRatingDeleteRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// A request that your app uses to delete ratings for albums, songs,
/// playlists, music videos, and stations for content in the user's iCloud library.
public struct MLibraryRatingDeleteRequest {
  private var type: LibraryRatingMusicItemType
  private var id: MusicItemID

  /// Creates a request to delete the rating for the unique identifier of the given library item.
  /// - Parameters:
  ///   - id: The unique identifier of the library item.
  ///   - type: The type of the library item. Possible values: `song`, `album`, `playlist`, `musicVideo`.
  public init(with id: MusicItemID, item type: LibraryRatingMusicItemType) {
    self.id = id
    self.type = type
  }

  /// Deletes the rating of the given library item
  /// that matches the unique identifier for the request.
  public func response() async throws -> Bool {
    let url = try libraryDeleteRatingsEndpointURL
    let request = MDataDeleteRequest(url: url)
    let response = try await request.response()
    // 204 EmptyBodyResponse - The modification was successful, but there’s no content in the response.
    return response.urlResponse.statusCode == 204
  }
}

extension MLibraryRatingDeleteRequest {
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
