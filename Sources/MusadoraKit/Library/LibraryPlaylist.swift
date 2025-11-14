//
//  LibraryPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 06/10/22.
//

import Foundation

/// Represents a playlist within a user's music library.
///
/// A `LibraryPlaylist` represents a playlist within a user's music library, providing detailed information about its attributes and metadata.
/// This includes details like its editability, public status, artwork, and more.
///
/// Example usage:
///
///     let playlist: LibraryPlaylist = fetchPlaylist(withID: someID)
///     print(playlist.attributes.name) // Prints the name of the playlist
///
public struct LibraryPlaylist: Codable, MusicItem {
  /// The unique identifier for the playlist.
  ///
  /// This identifier is unique to each playlist and can be used for fetching, updating, or deleting specific playlists.
  public let id: MusicItemID

  /// Detailed attributes associated with the playlist.
  ///
  /// This encompasses a range of information from its name, description, artwork, to its editability.
  public var attributes: Attributes

  /// Describes various characteristics of a playlist.
  ///
  /// The attributes provide a detailed look into the playlist's metadata and characteristics.
  public struct Attributes: Codable, Sendable {
    /// Indicates whether the playlist can be edited or not.
    ///
    /// If `true`, the playlist can be modified by the user.
    public let canEdit: Bool

    /// The name or title of the playlist.
    public let name: String

    /// A flag indicating the visibility of the playlist to others.
    ///
    /// If `true`, the playlist can be viewed by others.
    public let isPublic: Bool

    /// Specifies if the playlist includes content from the catalog.
    public let hasCatalog: Bool

    /// Parameters that determine how the playlist can be played.
    public var playParams: LibraryPlaylistPlayParameters

    /// A brief description of the playlist.
    ///
    /// This might include details about the theme of the playlist or its content.
    public let description: Description?

    /// Visual representation or image associated with the playlist.
    public let artwork: Artwork?

    /// A Boolean value indicating whether the playlist is in the user's favorites.
    public let inFavorites: Bool?

    /// The date and time when the playlist was added to the library.
    ///
    /// The date is in ISO 8601 format: YYYY-MM-DDThh:mm:ssZ
    public let dateAdded: String?

    /// The types of resources included in the playlist's tracks.
    ///
    /// Possible values include:
    /// - `library-music-videos`: The playlist contains library music videos
    /// - `library-songs`: The playlist contains library songs
    public let trackTypes: [String]?

    /// The date and time when the playlist was last modified.
    ///
    /// The date is in ISO 8601 format: YYYY-MM-DDThh:mm:ssZ
    public let lastModifiedDate: String?
  }

  /// Contains the textual description of a playlist.
  public struct Description: Codable, Sendable {
    /// The standard format of the description.
    ///
    /// This text provides insight or an overview of the playlist's theme or content.
    public let standard: String
  }

  /// Optionally retrieves the global identifier for the playlist.
  public var globalID: String? { attributes.playParams.globalID?.rawValue }
}

@available(macOS 14.0, *)
@available(watchOS, unavailable)
extension LibraryPlaylist: PlayableMusicItem {
  /// Retrieves the parameters required to play the playlist.
  ///
  /// - Returns: A set of play parameters or `nil` if they can't be determined.
  ///
  /// - Note: This property returns `nil` if encoding or decoding fails. This is expected behavior
  ///   when the play parameters structure doesn't match the expected format, and allows the
  ///   caller to handle the absence of play parameters gracefully.
  public var playParameters: PlayParameters? {
    let parameters: Data
    do {
      parameters = try JSONEncoder().encode(attributes.playParams)
    } catch {
      return nil
    }

    do {
      return try JSONDecoder().decode(PlayParameters.self, from: parameters)
    } catch {
      return nil
    }
  }
}

/// Defines the parameters required for playback of a library playlist.
public struct LibraryPlaylistPlayParameters: Codable, Sendable {
  /// The unique identifier associated with the playlist.
  public let id: MusicItemID

  /// Indicates if the playlist is sourced from the user's own library.
  public let isLibrary: Bool

  /// A global identifier, if present, associated with the playlist.
  public let globalID: MusicItemID?

  /// The kind of content.
  public let kind: String?

  /// A version hash for the playlist content.
  public let versionHash: String?

  private enum CodingKeys: String, CodingKey {
    case id, isLibrary, kind, versionHash
    case globalID = "globalId"
  }
}

extension LibraryPlaylist: Identifiable {}
