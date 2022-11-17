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

public struct MusicLibraryRatingAddRequest {

  /// The type of the library item to add rating for.
  private var type: LibraryRatingMusicItemType

  /// The unique identifier of the library item to add rating for.
  private var id: MusicItemID

  /// The rating of the library item.
  public var rating: RatingType

  /// Creates a request to add rating using a filter that matches a specific value.
  public init(for id: MusicItemID, item type: LibraryRatingMusicItemType, rating: RatingType) {
    self.id = id
    self.type = type
    self.rating = rating
  }

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
  var libraryAddRatingsEndpointURL: URL {
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
