//
//  AddRating.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 24/12/22.
//

import MusicKit

public extension MRating {
  /// Adds a rating for a song in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.addCatalogSong(for: "1632076865, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the song to add the rating for.
  ///   - rating: The rating to add for the song.
  /// - Returns: The added rating for the song as `Rating` object.
  ///
  /// - Throws: `MusadoraKitError.notFound`: If the song with the specified ID is not found in the catalog.
  static func addCatalogSong(for id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MCatalogRatingAddRequest(for: id, item: .song, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Adds a rating for a album in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.addCatalogAlbum(for: "1632076865, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the album to add the rating for.
  ///   - rating: The rating to add for the album.
  /// - Returns: The added rating for the album as `Rating` object.
  ///
  /// - Throws: `MusadoraKitError.notFound`: If the album with the specified ID is not found in the catalog.
  static func addCatalogAlbum(for id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MCatalogRatingAddRequest(for: id, item: .album, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Adds a rating for a playlist in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.addCatalogPlaylist(for: "1632076865, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the playlist to add the rating for.
  ///   - rating: The rating to add for the playlist.
  /// - Returns: The added rating for the playlist as `Rating` object.
  ///
  /// - Throws: `MusadoraKitError.notFound`: If the playlist with the specified ID is not found in the catalog.
  static func addCatalogPlaylist(for id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MCatalogRatingAddRequest(for: id, item: .playlist, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Adds a rating for a music video in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.addCatalogMusicVideo(for: "1632076865, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the music video to add the rating for.
  ///   - rating: The rating to add for the music video.
  /// - Returns: The added rating for the music video as `Rating` object.
  ///
  /// - Throws: `MusadoraKitError.notFound`: If the music video with the specified ID is not found in the catalog.
  static func addCatalogMusicVideo(for id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MCatalogRatingAddRequest(for: id, item: .musicVideo, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Adds a rating for a station in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MRating.addCatalogStation(for: "1632076865, rating: .like)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the station to add the rating for.
  ///   - rating: The rating to add for the station.
  /// - Returns: The added rating for the station as `Rating` object.
  ///
  /// - Throws: `MusadoraKitError.notFound`: If the station with the specified ID is not found in the catalog.
  static func addCatalogStation(for id: MusicItemID, rating: RatingType) async throws -> Rating {
    let request = MCatalogRatingAddRequest(for: id, item: .station, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return rating
  }
}
