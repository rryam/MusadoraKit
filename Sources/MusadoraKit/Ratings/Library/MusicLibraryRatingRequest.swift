//
//  MusicLibraryRatingRequest.swift
//
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {
  static func librarySongRating(id: MusicItemID) async throws -> Rating {
    let request = MusicLibraryRatingRequest(for: id, item: .song)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func librarySongsRating(ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicLibraryRatingRequest(for: ids, item: .song)
    let response = try await request.response()
    return response.data
  }

  static func libraryMusicVideoRating(id: MusicItemID) async throws -> Rating {
    let request = MusicLibraryRatingRequest(for: id, item: .musicVideo)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryMusicVideosRating(ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicLibraryRatingRequest(for: ids, item: .musicVideo)
    let response = try await request.response()
    return response.data
  }

  static func libraryPlaylistRating(id: MusicItemID) async throws -> Rating {
    let request = MusicLibraryRatingRequest(for: id, item: .playlist)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryPlaylistsRating(ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicLibraryRatingRequest(for: ids, item: .playlist)
    let response = try await request.response()
    return response.data
  }

  static func libraryAlbumRating(id: MusicItemID) async throws -> Rating {
    let request = MusicLibraryRatingRequest(for: id, item: .album)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func libraryAlbumsRating(ids: [MusicItemID]) async throws -> [Rating] {
    let request = MusicLibraryRatingRequest(for: ids, item: .album)
    let response = try await request.response()
    return response.data
  }
}

/// A request that your app uses to fetch and set
/// ratings for albums, songs, playlists, music videos, and stations
/// for content in the user's iCloud library.
public struct MusicLibraryRatingRequest {

  /// The type of the library item to
  /// get rating for.
  private var type: LibraryRatingMusicItemType

  /// The unique identifier(s) of the library item(s) to
  /// get rating for.
  private var ids: [MusicItemID]

  /// Creates a request to fetch items using a filter that matches
  /// a specific value.
  public init(for id: MusicItemID, item type: LibraryRatingMusicItemType) {
    self.ids = [id]
    self.type = type
  }

  /// Creates a request to get rating using a filter that matches
  /// any value from an array of possible identifiers.
  public init(for ids: [MusicItemID], item type: LibraryRatingMusicItemType) {
    self.ids = ids
    self.type = type
  }

  public func response() async throws -> RatingsResponse {
    let url = try libraryRatingsEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    return try JSONDecoder().decode(RatingsResponse.self, from: response.data)
  }
}

extension MusicLibraryRatingRequest {
  internal var libraryRatingsEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem]?
      components.path = "me/ratings/\(type.rawValue)"

      queryItems = [URLQueryItem(name: "ids", value: ids.map { $0.rawValue }.joined(separator: ","))]

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
