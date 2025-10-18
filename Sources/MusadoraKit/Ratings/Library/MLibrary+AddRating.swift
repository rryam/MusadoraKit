// 
//  AddLibraryRating.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//

public extension MLibrary {
  /// Adds a rating for a song in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.addRating(for: song, rating: .like)
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
  /// - Throws: `MRatingError.notFound`: If the song is not found in the user's library.
  static func addRating(for song: Song, rating: RatingType) async throws -> Rating {
    try await addRating(with: song.id, item: .song, rating: rating)
  }

  /// Adds a rating for an album in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.addRating(for: album, rating: .like)
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
  /// - Throws: `MRatingError.notFound`: If the album is not found in the user's library.
  static func addRating(for album: Album, rating: RatingType) async throws -> Rating {
    try await addRating(with: album.id, item: .album, rating: rating)
  }

  /// Adds a rating for a playlist in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.addRating(for: playlist, rating: .like)
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
  /// - Throws: `MRatingError.notFound`: If the playlist is not found in the user's library.
  static func addRating(for playlist: Playlist, rating: RatingType) async throws -> Rating {
    try await addRating(with: playlist.id, item: .playlist, rating: rating)
  }

  /// Adds a rating for a music video in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.addRating(for: musicVideo, rating: .like)
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
  /// - Throws: `MRatingError.notFound`: If the music video is not found in the user's library.
  static func addRating(for musicVideo: MusicVideo, rating: RatingType) async throws -> Rating {
    try await addRating(with: musicVideo.id, item: .musicVideo, rating: rating)
  }

  /// Adds a rating for a music item in the user's library.
  ///
  /// Use this method when you don't have the particular music item, but have access
  /// to the unique identifier of the music item.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.addRating(for: "12345678", item: .playlist, rating: .dislike)
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
  /// - Throws: `MRatingError.notFound`: If the music item with the specified ID is not found in the user's library.
  static func addRating(with id: MusicItemID, item: LibraryRatingMusicItemType, rating: RatingType) async throws -> Rating {
    let request = MLibraryRatingAddRequest(with: id, item: item, rating: rating)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }
}
