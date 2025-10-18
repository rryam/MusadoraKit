//
//  MLibraryPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 06/10/22.
//

import Foundation

/// Represents a playlist within a user's music library.
///
/// A `MLibraryPlaylist` provides a detailed view of a playlist, including its attributes and associated metadata.
/// This includes details like its editability, public status, artwork, and more.
///
/// Example usage:
///
///     let playlist: MLibraryPlaylist = fetchPlaylist(withID: someID)
///     print(playlist.attributes.name) // Prints the name of the playlist
///
public struct MLibraryPlaylist: Codable, MusicItem {
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
    public var playParams: MPlayParameters

    /// A brief description of the playlist.
    ///
    /// This might include details about the theme of the playlist or its content.
    public let description: Description?

    /// Visual representation or image associated with the playlist.
    public let artwork: Artwork?
  }

  /// Contains the textual description of a playlist.
  public struct Description: Codable, Sendable {
    /// The standard format of the description.
    ///
    /// This text provides insight or an overview of the playlist's theme or content.
    public let standard: String
  }

  /// Defines the parameters required for playback of the playlist.
  public struct MPlayParameters: Codable, Sendable {
    /// The unique identifier associated with the playlist.
    public let id: MusicItemID

    /// Indicates if the playlist is sourced from the user's own library.
    public let isLibrary: Bool

    /// A global identifier, if present, associated with the playlist.
    ///
    /// This might be used for global operations or recognition across different systems.
    public let globalID: MusicItemID?

    enum CodingKeys: String, CodingKey {
      case id, isLibrary
      case globalID = "globalId"
    }
  }

  /// Optionally retrieves the global identifier for the playlist.
  public var globalID: String? {
    attributes.playParams.globalID?.rawValue
  }
}

@available(macOS 14.0, *)
@available(watchOS, unavailable)
extension MLibraryPlaylist: PlayableMusicItem {
  /// Retrieves the parameters required to play the playlist.
  ///
  /// - Returns: A set of play parameters or `nil` if they can't be determined.
  public var playParameters: PlayParameters? {
    get {
      let parameters = try? JSONEncoder().encode(attributes.playParams)

      guard let parameters else { return nil }

      let playParams = try? JSONDecoder().decode(PlayParameters.self, from: parameters)
      return playParams
    }
  }
}

extension MLibraryPlaylist: Identifiable {}
