//
//  DeleteLibraryRating.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//

import Foundation
import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MLibrary {

  /// Delete a rating for a song in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let success = try await MLibrary.deleteRating(for: song)
  ///
  ///    if success {
  ///      print("Rating for song \(song) successfully deleted from user's library.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the song \(song) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - song: The song to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for song: Song) async throws -> Bool {
    try await deleteRating(for: song.id, item: .song)
  }

  /// Delete a rating for an album in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let success = try await MLibrary.deleteRating(for: album)
  ///
  ///    if success {
  ///      print("Rating for album \(album) successfully deleted from user's library.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the album \(album) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The album to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for album: Album) async throws -> Bool {
    try await deleteRating(for: album.id, item: .album)
  }

  /// Delete a rating for a playlist in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let success = try await MLibrary.deleteRating(for: playlist)
  ///
  ///    if success {
  ///      print("Rating for playlist \(playlist) successfully deleted from user's library.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the playlist \(playlist) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - playlist: The playlist to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for playlist: Playlist) async throws -> Bool {
    try await deleteRating(for: playlist.id, item: .playlist)
  }

  /// Delete a rating for a music video in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let success = try await MLibrary.deleteRating(for: musicVideo)
  ///
  ///    if success {
  ///      print("Rating for music video \(musicVideo) successfully deleted from user's library.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the music video \(musicVideo) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - musicVideo: The music video to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for musicVideo: MusicVideo) async throws -> Bool {
    try await deleteRating(for: musicVideo.id, item: .musicVideo)
  }

  /// Delete a rating for a music item in the user's library.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let id: MusicItemID = "12345678"
  ///    let success = try await MLibrary.deleteRating(for: id)
  ///
  ///    if success {
  ///      print("Rating for music item with ID \(id) successfully deleted from user's library.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the music item with ID \(id) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the music item to delete the rating for.
  ///   - item: The type of the music item to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for id: MusicItemID, item: LibraryRatingMusicItemType) async throws -> Bool {
    let request = MLibraryRatingDeleteRequest(for: id, item: item)
    let response = try await request.response()
    return response
  }
}
