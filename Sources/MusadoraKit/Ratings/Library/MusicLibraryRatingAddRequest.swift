//
//  MusicLibraryRatingAddRequest.swift
//  MusicLibraryRatingAddRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func librarySongAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicLibraryRatingAddRequest(for: id, item: .song, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryAlbumAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicLibraryRatingAddRequest(for: id, item: .album, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryPlaylistAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicLibraryRatingAddRequest(for: id, item: .playlist, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryMusicVideoAddRating(id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MusicLibraryRatingAddRequest(for: id, item: .musicVideo, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }
}

/// A request that your app uses to add ratings for albums, songs,
/// playlists, music videos, and stations for content in the user's iCloud library.
public struct MusicLibraryRatingAddRequest {

  private var type: LibraryRatingMusicItemType
  private var id: MusicItemID

  /// The rating of the library item.
  public var rating: RatingType

  /// Creates a request to add the rating for the unique identifier of the given library item.
  /// - Parameters:
  ///   - id: The unique identifier of the library item.
  ///   - type: The type of the library item. Possible values: `song`, `album`, `playlist`, `musicVideo`.
  ///   - rating: The rating to add for the given library item. Possible values: `like`, `dislike`.
  public init(for id: MusicItemID, item type: LibraryRatingMusicItemType, rating: RatingType) {
    self.id = id
    self.type = type
    self.rating = rating
  }

  /// Adds the given rating for the given library item
  /// that matches the unique identifier(s) for the request.
  public func response() async throws -> RatingsResponse {
    let url = try libraryAddRatingsEndpointURL

    let rating = RatingRequest(value: rating)
    let data = try JSONEncoder().encode(rating)

    let request = MusicDataPutRequest(url: url, data: data)
    let response = try await request.response()
    return try JSONDecoder().decode(RatingsResponse.self, from: response.data)
  }
}

extension MusicLibraryRatingAddRequest {
  internal var libraryAddRatingsEndpointURL: URL {
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
