//
//  DeleteCatalogRating.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//

import Foundation

public extension MCatalog {

  /// Delete a rating for a song in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let success = try await MCatalog.deleteRating(for: song)
  ///
  ///    if success {
  ///      print("Rating for song \(song) successfully deleted from catalog.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the song \(song) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - song: The song to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for song: Song) async throws -> Bool {
    try await deleteRating(for: song.id, item: .song)
  }

  /// Delete a rating for an album in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let success = try await MCatalog.deleteRating(for: album)
  ///
  ///    if success {
  ///      print("Rating for album \(album) successfully deleted from catalog.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the album \(album) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The album to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for album: Album) async throws -> Bool {
    try await deleteRating(for: album.id, item: .album)
  }

  /// Delete a rating for a playlist in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let success = try await MCatalog.deleteRating(for: playlist)
  ///
  ///    if success {
  ///      print("Rating for playlist \(playlist) successfully deleted from catalog.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the playlist \(playlist) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The playlist to delete the rating for.
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
  ///      print("Rating for music video \(playlist) successfully deleted from user's library.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the music video \(playlist) from user's library: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - musicVideo: The music video to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for musicVideo: MusicVideo) async throws -> Bool {
    try await deleteRating(for: musicVideo.id, item: .musicVideo)
  }

  /// Delete a rating for a station in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let success = try await MCatalog.deleteRating(for: station)
  ///
  ///    if success {
  ///      print("Rating for station \(station) successfully deleted from catalog.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the station \(station) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The station to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for station: Station) async throws -> Bool {
    try await deleteRating(for: station.id, item: .station)
  }

  /// Delete a rating for a music item in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do {
  ///    let id: MusicItemID = "12345678"
  ///    let success = try await MCatalog.deleteRating(for: id)
  ///
  ///    if success {
  ///      print("Rating for music item with ID \(id) successfully deleted from catalog.")
  ///    }
  ///  } catch {
  ///    print("Error deleting the rating for the music item with ID \(id) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the music item to delete the rating for.
  ///   - item: The type of the music item to delete the rating for.
  /// - Returns: A boolean value indicating whether the delete operation was successful.
  static func deleteRating(for id: MusicItemID, item: CatalogRatingMusicItemType) async throws -> Bool {
    let request = MCatalogRatingDeleteRequest(with: id, item: item)
    let response = try await request.response()
    return response
  }
}
