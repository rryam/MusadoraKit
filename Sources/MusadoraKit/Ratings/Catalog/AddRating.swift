//
//  AddRating.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 24/12/22.
//

import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MCatalog {
  /// Adds a rating for a song in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.addRating(for: song, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - song: The song to add the rating for.
  ///   - rating: The rating to add for the song.
  /// - Returns: The added rating for the song as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the song is not found in the catalog.
  static func addRating(for song: Song, rating: RatingType) async throws -> Rating {
    try await addRating(for: song.id, item: .song, rating: rating)
  }

  /// Adds a rating for an album in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.addRating(for: album, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The album to add the rating for.
  ///   - rating: The rating to add for the album.
  /// - Returns: The added rating for the album as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the album is not found in the catalog.
  static func addRating(for album: Album, rating: RatingType) async throws -> Rating {
    try await addRating(for: album.id, item: .album, rating: rating)
  }

  /// Adds a rating for a playlist in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.addRating(for: playlist, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - playlist: The playlist to add the rating for.
  ///   - rating: The rating to add for the playlist.
  /// - Returns: The added rating for the playlist as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the playlist with the specified ID is not found in the catalog.
  static func addRating(for playlist: Playlist, rating: RatingType) async throws -> Rating {
    try await addRating(for: playlist.id, item: .playlist, rating: rating)
  }

  /// Adds a rating for a music video in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.addRating(for: musicVideo, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - musicVideo: The music video to add the rating for.
  ///   - rating: The rating to add for the music video.
  /// - Returns: The added rating for the music video as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the music video with the specified ID is not found in the catalog.
  static func addRating(for musicVideo: MusicVideo, rating: RatingType) async throws -> Rating {
    try await addRating(for: musicVideo.id, item: .musicVideo, rating: rating)
  }

  /// Adds a rating for a station in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.addRating(for: station, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - station: The station to add the rating for.
  ///   - rating: The rating to add for the station.
  /// - Returns: The added rating for the station as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the station with the specified ID is not found in the catalog.
  static func addRating(for station: Station, rating: RatingType) async throws -> Rating {
    try await addRating(for: station.id, item: .station, rating: rating)
  }

  /// Adds a rating for a music item in the catalog.
  ///
  /// Use this method when you don't have the particular music item, but have access
  /// to the unique identifier of the music item.
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.addRating(for: "12345678", item: .playlist, rating: .dislike)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the music item to add the rating for.
  ///   - item: The music item to add the rating for.
  ///   - rating: The rating to add for the music item.
  /// - Returns: The added rating for the music item as `Rating` object.
  ///
  /// - Throws: `MRatingError.notFound`: If the music item with the specified ID is not found in the catalog.
  static func addRating(for id: MusicItemID, item: CatalogRatingMusicItemType, rating: RatingType) async throws -> Rating {
    let request = MCatalogRatingAddRequest(for: id, item: item, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }
}
