//
//  MusicCatalogRatingRequest.swift
//  MusicCatalogRatingRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public extension MCatalog {

  /// Get the rating for an album in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: album)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The album to get the rating for.
  /// - Returns: The rating for the album as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the album is not found in the catalog.
  static func getRating(for album: Album) async throws -> Rating {
    let id = album.id
    let request = MCatalogRatingRequest(for: id, item: .album)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for albums in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let ratings = try await MCatalog.getRatings(for: albums)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - albums: The albums to get the rating for.
  /// - Returns: The ratings for the albums as an array of `Rating` object.
  static func getRatings(for albums: Albums) async throws -> [Rating] {
    let ids = albums.map { $0.id }
    let request = MCatalogRatingRequest(for: ids, item: .album)
    let response = try await request.response()
    return response.data
  }

  /// Get the rating for a song in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.getCatalogSong(for: "1632076865")
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the song to get the rating for.
  /// - Returns: The rating for the song as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the song with the specified ID is not found in the catalog.
  static func getCatalogSong(for id: MusicItemID) async throws -> Rating {
    let request = MCatalogRatingRequest(for: id, item: .song)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for songs in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let ratings = try await MRating.getCatalogSongs(for: ["1632076865", "1632076866"])
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifiers of the songs to get the rating for.
  /// - Returns: The ratings for the songs as an array of `Rating` object.
  static func getCatalogSongs(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MCatalogRatingRequest(for: ids, item: .song)
    let response = try await request.response()
    return response.data
  }

  /// Get the rating for a music video in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.getCatalogMusicVideo(for: "1632076865")
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the music video to get the rating for.
  /// - Returns: The rating for the music video as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the music video with the specified ID is not found in the catalog.
  static func getCatalogMusicVideo(for id: MusicItemID) async throws -> Rating {
    let request = MCatalogRatingRequest(for: id, item: .musicVideo)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for music videos in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.getCatalogMusicVideos(for: ["1632076865", "1632076866"])
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifiers of the music videos to get the rating for.
  /// - Returns: The ratings for the music videos as an array of `Rating` object.
  static func getCatalogMusicVideos(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MCatalogRatingRequest(for: ids, item: .musicVideo)
    let response = try await request.response()
    return response.data
  }

  /// Get the rating for a playlist in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.getCatalogPlaylist(for: "1632076865")
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the playlist to get the rating for.
  /// - Returns: The rating for the playlist as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the playlist with the specified ID is not found in the catalog.
  static func getCatalogPlaylist(for id: MusicItemID) async throws -> Rating {
    let request = MCatalogRatingRequest(for: id, item: .playlist)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func getCatalogPlaylists(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MCatalogRatingRequest(for: ids, item: .playlist)
    let response = try await request.response()
    return response.data
  }

  /// Get the rating for a station in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.getCatalogStation(for: "1632076865")
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the station to get the rating for.
  /// - Returns: The rating for the station as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the station with the specified ID is not found in the catalog.
  static func getCatalogStation(for id: MusicItemID) async throws -> Rating {
    let request = MCatalogRatingRequest(for: id, item: .station)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  static func getCatalogStations(for ids: [MusicItemID]) async throws -> [Rating] {
    let request = MCatalogRatingRequest(for: ids, item: .station)
    let response = try await request.response()
    return response.data
  }
}

/// A request that your app uses to get ratings for albums, songs,
/// playlists, music videos, and stations for content in the Apple Music catalog.
public struct MCatalogRatingRequest {

  private var type: CatalogRatingMusicItemType
  private var ids: [MusicItemID]

  /// Creates a request to get ratings for the unique identifiers of the given catalog item.
  /// - Parameters:
  ///   - ids: The unique identifiers of the catalog item.
  ///   - type: The type of the catalog item. Possible values: `song`, `album`, `playlist`, `musicVideo`, `station`.
  public init(for ids: [MusicItemID], item type: CatalogRatingMusicItemType) {
    self.type = type
    self.ids = ids
  }

  /// Creates a request to get the rating for the unique identifier of the given catalog item.
  /// - Parameters:
  ///   - id: The unique identifier of the catalog item.
  ///   - type: The type of the catalog item. Possible values: `song`, `album`, `playlist`, `musicVideo`, `station`.
  public init(for id: MusicItemID, item type: CatalogRatingMusicItemType) {
    self.type = type
    self.ids = [id]
  }

  /// Fetches the given rating(s) of the given catalog item
  /// that matches the unique identifier(s) for the request.
  public func response() async throws -> RatingsResponse {
    let url = try catalogRatingsEndpointURL
    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()
    return try JSONDecoder().decode(RatingsResponse.self, from: response.data)
  }
}

extension MCatalogRatingRequest {
  internal var catalogRatingsEndpointURL: URL {
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
