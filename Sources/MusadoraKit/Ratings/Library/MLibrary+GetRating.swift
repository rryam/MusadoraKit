// 
//  GetLibraryRating.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//

public extension MLibrary {
  /// Get the rating for an album in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.getRating(for: album)
  ///  } catch {
  ///    print("Error getting the rating for the album \(album) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The album to get the rating for.
  /// - Returns: The rating for the album as `Rating` object.
  ///
  /// - Throws: `MLibraryError.notFound`: If the album is not found in the user's library.
  static func getRating(for album: Album) async throws -> Rating {
    try await getRating(with: album.id, item: .album)
  }

  /// Get the ratings for albums in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let ratings = try await MLibrary.getRatings(for: albums)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - albums: The albums to get the rating for.
  /// - Returns: The ratings for the albums as an array of `Rating` object.
  static func getRatings(for albums: Albums) async throws -> Ratings {
    try await getRatings(with: albums.map { $0.id }, item: .album)
  }

  /// Get the rating for a song in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.getRating(for: song)
  ///  } catch {
  ///    print("Error getting the rating for the song \(song) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - song: The song to get the rating for.
  /// - Returns: The rating for the song as `Rating` object.
  ///
  /// - Throws: `MLibraryError.notFound`: If the song is not found in the user's library.
  static func getRating(for song: Song) async throws -> Rating {
    try await getRating(with: song.id, item: .song)
  }

  /// Get the ratings for songs in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let ratings = try await MLibrary.getRatings(for: songs)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - songs: The songs to get the rating for.
  /// - Returns: The ratings for the songs as an array of `Rating` object.
  static func getRatings(for songs: Songs) async throws -> Ratings {
    try await getRatings(with: songs.map { $0.id }, item: .song)
  }

  /// Get the rating for a music video in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.getRating(for: musicVideo)
  ///  } catch {
  ///    print("Error getting the rating for the music video \(musicVideo) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - musicVideo: The music video to get the rating for.
  /// - Returns: The rating for the music video as `Rating` object.
  ///
  /// - Throws: `MLibraryError.notFound`: If the music video is not found in the user's library.
  static func getRating(for musicVideo: MusicVideo) async throws -> Rating {
    try await getRating(with: musicVideo.id, item: .musicVideo)
  }

  /// Get the ratings for music videos in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.getRatings(for: musicVideos)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - musicVideos: The music videos to get the rating for.
  /// - Returns: The ratings for the music videos as an array of `Rating` object.
  static func getRatings(for musicVideos: MusicVideos) async throws -> Ratings {
    try await getRatings(with: musicVideos.map { $0.id }, item: .musicVideo)
  }

  /// Get the rating for a playlist in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.getRating(for: playlist)
  ///  } catch {
  ///    print("Error getting the rating for the playlist \(playlist) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - playlist: The playlist to get the rating for.
  /// - Returns: The rating for the playlist as `Rating` object.
  ///
  /// - Throws: `MLibraryError.notFound`: If the playlist is not found in the user's library.
  static func getRating(for playlist: Playlist) async throws -> Rating {
    try await getRating(with: playlist.id, item: .playlist)
  }

  /// Get the ratings for playlists in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MLibrary.getRatings(for: playlists)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - playlists: The playlists to get the rating for.
  /// - Returns: The ratings for the playlists as an array of `Rating` object.
  static func getRatings(for playlists: Playlists) async throws -> Ratings {
    try await getRatings(with: playlists.map { $0.id }, item: .playlist)
  }

  /// Get the rating for a music item in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let id: MusicItemID = "12345678"
  ///    let rating = try await MLibrary.getRating(for: id)
  ///  } catch {
  ///    print("Error getting the rating for the music item with ID \(id) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the music item to get the rating for.
  ///   - item: The type of the music item to get the rating for.
  /// - Returns: The rating for the music item as `Rating` object.
  ///
  /// - Throws: `MLibraryError.notFound`: If the music item with the specified ID is not found in the user's library.
  static func getRating(with id: MusicItemID, item: LibraryRatingMusicItemType) async throws -> Rating {
    let request = MLibraryRatingRequest(with: [id], item: item)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for music items in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let ids: [MusicItemID] = ["12345678", "87653214"]
  ///    let rating = try await MLibrary.getRating(for: ids)
  ///  } catch {
  ///    print("Error getting the rating for the music items with IDs \(ids) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers of the music items to get the rating for.
  ///   - item: The type of the music items to get the rating for.
  /// - Returns: The ratings for the music items as an array of `Rating` object.
  ///
  /// - Throws: `MLibraryError.notFound`: If the music items with the IDs is not found in the user's library.
  static func getRatings(with ids: [MusicItemID], item: LibraryRatingMusicItemType) async throws -> Ratings {
    let request = MLibraryRatingRequest(with: ids, item: item)
    let response = try await request.response()
    return response.data
  }
}
