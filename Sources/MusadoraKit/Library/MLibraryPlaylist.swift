//
//  MLibraryPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 06/10/22.
//

import Foundation

/// A representation of a playlist in a user's music library.
public struct MLibraryPlaylist: Codable, MusicItem {

  /// The unique identifier of the playlist.
  public let id: MusicItemID

  /// The attributes of the playlist.
  public let attributes: Attributes

  /// A structure containing the attributes of a playlist.
  public struct Attributes: Codable, Sendable {

    /// A boolean indicating if the playlist can be edited.
    public let canEdit: Bool

    /// The name of the playlist.
    public let name: String

    /// A boolean indicating if the playlist is public.
    public let isPublic: Bool

    /// A boolean indicating if the playlist contains catalog content.
    public let hasCatalog: Bool

    /// The play parameters for the playlist.
    public let playParams: PlayParameters

    /// The description of the playlist, if available.
    public let description: Description?

    /// The artwork associated with the playlist, if available.
    public let artwork: Artwork?
  }

  /// A structure representing the description of a playlist.
  public struct Description: Codable, Sendable {

    /// The standard text of the description.
    public let standard: String
  }

  /// A structure representing the play parameters of a playlist.
  public struct PlayParameters: Codable, Sendable {

    /// The identifier of the playlist.
    public let id: MusicItemID

    /// A boolean indicating if the playlist is from the user's library.
    public let isLibrary: Bool

    /// The global identifier of the playlist, if available.
    public let globalID: MusicItemID?

    enum CodingKeys: String, CodingKey {
      case id, isLibrary
      case globalID = "globalId"
    }
  }

  /// The global identifier of the playlist, if available.
  public var globalID: String? {
    attributes.playParams.globalID?.rawValue
  }
}
