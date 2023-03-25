//
//  MusicLibraryRatingRequest.swift
//
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// A collection of ratings for content items in the Apple Music Catalog.
public typealias Ratings = [Rating]

/// A request that your app uses to get ratings for albums, songs,
/// playlists, and music videos for content in the user's iCloud library.
public struct MLibraryRatingRequest {

  private var type: LibraryRatingMusicItemType
  private var ids: [MusicItemID]

  /// Creates a request to get ratings for the unique identifiers of the given library item.
  /// - Parameters:
  ///   - id: The unique identifiers of the library item.
  ///   - type: The type of the library item. Possible values: `song`, `album`, `playlist`, `musicVideo`.
  public init(with ids: [MusicItemID], item type: LibraryRatingMusicItemType) {
    self.ids = ids
    self.type = type
  }

  /// Fetches the given rating(s) of the given library item
  /// that matches the unique identifier(s) for the request.
  public func response() async throws -> RatingsResponse {
    let url = try libraryRatingsEndpointURL
    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()
    return try JSONDecoder().decode(RatingsResponse.self, from: response.data)
  }
}

extension MLibraryRatingRequest {
  internal var libraryRatingsEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem]?
      components.path = "me/ratings/\(type.rawValue)"

      let ids = ids.map { $0.rawValue }.joined(separator: ",")
      queryItems = [URLQueryItem(name: "ids", value: ids)]

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
