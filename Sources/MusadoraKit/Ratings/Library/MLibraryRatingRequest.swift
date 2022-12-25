//
//  MusicLibraryRatingRequest.swift
//
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public typealias Ratings = [Rating]

public extension MusadoraKit {
  static func librarySongRating(id: MusicItemID) async throws -> Rating {
    let request = MLibraryRatingRequest(for: id, item: .song)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func librarySongsRating(ids: [MusicItemID]) async throws -> Ratings {
    let request = MLibraryRatingRequest(for: ids, item: .song)
    let response = try await request.response()
    return response.data
  }

  static func libraryMusicVideoRating(id: MusicItemID) async throws -> Rating {
    let request = MLibraryRatingRequest(for: id, item: .musicVideo)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryMusicVideosRating(ids: [MusicItemID]) async throws -> Ratings {
    let request = MLibraryRatingRequest(for: ids, item: .musicVideo)
    let response = try await request.response()
    return response.data
  }

  static func libraryPlaylistRating(id: MusicItemID) async throws -> Rating {
    let request = MLibraryRatingRequest(for: id, item: .playlist)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryPlaylistsRating(ids: [MusicItemID]) async throws -> Ratings {
    let request = MLibraryRatingRequest(for: ids, item: .playlist)
    let response = try await request.response()
    return response.data
  }

  static func libraryAlbumRating(id: MusicItemID) async throws -> Rating {
    let request = MLibraryRatingRequest(for: id, item: .album)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryAlbumsRating(ids: [MusicItemID]) async throws -> Ratings {
    let request = MLibraryRatingRequest(for: ids, item: .album)
    let response = try await request.response()
    return response.data
  }
}

/// A request that your app uses to get ratings for albums, songs,
/// playlists, and music videos for content in the user's iCloud library.
public struct MLibraryRatingRequest {

  private var type: LibraryRatingMusicItemType
  private var ids: [MusicItemID]

  /// Creates a request to get the rating for the unique identifier of the given library item.
  /// - Parameters:
  ///   - id: The unique identifier of the library item.
  ///   - type: The type of the library item. Possible values: `song`, `album`, `playlist`, `musicVideo`.
  public init(for id: MusicItemID, item type: LibraryRatingMusicItemType) {
    self.ids = [id]
    self.type = type
  }

  /// Creates a request to get ratings for the unique identifiers of the given library item.
  /// - Parameters:
  ///   - id: The unique identifiers of the library item.
  ///   - type: The type of the library item. Possible values: `song`, `album`, `playlist`, `musicVideo`.
  public init(for ids: [MusicItemID], item type: LibraryRatingMusicItemType) {
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
