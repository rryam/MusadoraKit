//
//  LibraryMusicItemType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// Set the `itemType` to indicate the type of library item for which you want to fetch ratings.
///
/// ### Usage Example:
///
/// ```swift
/// let itemType: LibraryMusicItemType = .song
///
/// do {
///     let ratings = try await MusicLibraryRatingRequest(with: ids, item: itemType).response()
///     // Use the ratings for further processing.
/// } catch {
///     // Handle the error.
/// }
/// ```
public enum LibraryMusicItemType: String, Codable {
  /// Represents songs in the music library.
  case songs

  /// Represents playlists in the music library.
  case playlists

  /// Represents albums in the music library.
  case albums

  /// Represents artists in the music library.
  case artists

  /// Represents music videos in the music library with a raw value of "music-videos".
  case musicVideos = "music-videos"

  /// A computed property that generates a type string for the item.
  ///
  /// The type string is used in requests to identify the specific item type.
  public var type: String {
    "ids[\(rawValue)]".removingPercentEncoding ?? "ids[\(rawValue)]"
  }
}

/// An extension providing utility methods for `LibraryMusicItemType`.
public extension LibraryMusicItemType {
  /// Returns the `LibraryMusicItemType` corresponding to a given type conforming to `FilterableLibraryItem`.
  ///
  /// Use this method to map a type to the appropriate library item type for operations involving music library items.
  ///
  /// - Parameter item: The type conforming to `FilterableLibraryItem`.
  /// - Returns: The `LibraryMusicItemType` corresponding to the provided type.
  ///
  /// - Throws: An error if the input type does not match any known library item types.
  static func path(for item: any FilterableLibraryItem.Type) throws -> Self {
    let path: LibraryMusicItemType

    switch item {
    case is Song.Type:
      path = .songs
    case is Album.Type:
      path = .albums
    case is Artist.Type:
      path = .artists
    case is MusicVideo.Type:
      path = .musicVideos
    case is Playlist.Type:
      path = .playlists
    default:
      throw NSError(domain: "Wrong library music item type.", code: 0)
    }

    return path
  }
}
