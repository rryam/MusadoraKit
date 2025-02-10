//
//  LibraryPlaylistFolder.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 26/12/22.
//

import Foundation

/// A structure representing a playlist folder in the user's library.
///
/// `LibraryPlaylistFolder` provides information about a folder that contains playlists
/// in the user's Apple Music library, including its metadata and relationships.
///
/// Example usage:
/// ```swift
/// let folder = try await MLibrary.playlistFolder(id: "folder_id")
/// print(folder.attributes?.name)
/// print(folder.attributes?.dateAdded)
/// ```
public struct LibraryPlaylistFolder: Codable, Sendable {
  /// The unique identifier of the playlist folder.
  public let id: String

  /// The type of the resource, typically "library-playlist-folders".
  public let type: String

  /// The attributes of the playlist folder.
  public let attributes: Attributes?

  /// The relationships of the playlist folder.
  public let relationships: Relationships?

  /// The attributes associated with a playlist folder.
  public struct Attributes: Codable, Sendable {
    /// The date when the folder was added to the library.
    public let dateAdded: Date

    /// The name of the playlist folder.
    public let name: String
  }

  /// The relationships associated with a playlist folder.
  public struct Relationships: Codable, Sendable {
    // Reserved for future relationships
  }
}
