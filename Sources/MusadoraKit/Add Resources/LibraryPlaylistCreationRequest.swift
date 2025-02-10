//
//  LibraryPlaylistCreationRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 28/01/23.
//

import Foundation

/// A request to create a playlist in the user's library.
///
/// This structure is used to send a request to create a new playlist in the user's music library.
/// It includes attributes for the playlist and optional relationships, such as tracks to be included in the new playlist.
struct LibraryPlaylistCreationRequest: Codable {

  /// A dictionary that includes strings for the name and description of the new playlist.
  var attributes: PlaylistCreationAttributes

  /// To include tracks for the new playlist.
  var relationships: PlaylistCreationRelationships?
}

/// Attributes for creating a playlist.
///
/// This structure includes the name and an optional description for the playlist being created.
struct PlaylistCreationAttributes: Codable {

  /// The name of the playlist.
  var name: String

  /// The description of the playlist.
  var description: String?
}

/// Relationships for creating a playlist.
///
/// This structure includes the tracks to be included in the playlist being created.
struct PlaylistCreationRelationships: Codable {
  var tracks: PlaylistCreationTracks
}

/// The tracks to be included in the playlist being created.
///
/// This structure includes data for the tracks to be included in the playlist being created.
struct PlaylistCreationTracks: Codable {

  /// Data of the tracks to add to the created library playlist.
  var data: [PlaylistCreationData]
}

/// The data for a track to be included in the playlist being created.
///
/// This structure includes the unique identifier and type of the track.
struct PlaylistCreationData: Codable {

  /// The unique identifier for the track.
  /// This ID can be a catalog identifier or a library identifier, depending on the track type.
  var id: String

  /// The type of the track to be added.
  var type: LibraryPlaylistCreationTrackType
}

/// A protocol that represents a music item that can be added to a playlist.
///
/// This protocol includes a property for the play parameters of the music item.
public protocol PlaylistAddable: MusicItem {

  /// The parameters to use to play the item.
  var playParameters: PlayParameters? { get }
}

/// An extension of `Song` that makes it able to be added to a playlist.
extension Song: PlaylistAddable {}

/// An extension of `Track` that makes it able to be added to a playlist.
extension Track: PlaylistAddable {}

/// An extension of `MusicVideo` that makes it able to be added to a playlist.
extension MusicVideo: PlaylistAddable {}

/// Parameters used to play a music item in Apple Music.
///
/// This structure contains the necessary information to identify and play a music item,
/// whether it's from the Apple Music catalog or the user's library.
///
/// Example usage:
/// ```swift
/// let parameters = MusicPlayParameters(
///     id: song.id,
///     isLibrary: true,
///     kind: "song",
///     catalogId: song.catalogId
/// )
/// ```
public struct MusicPlayParameters: Codable {
  /// The unique identifier of the music item.
  public var id: MusicItemID

  /// Indicates whether the item is from the user's library.
  public var isLibrary: Bool?

  /// The kind of music item (e.g., "song", "album", "playlist").
  public var kind: String

  /// The catalog identifier if the item is from the Apple Music catalog.
  public var catalogId: MusicItemID?

  /// The global identifier used across different Apple Music storefronts.
  public var globalId: MusicItemID?
}

/// An enumeration of the types of tracks that can be added to a playlist.
enum LibraryPlaylistCreationTrackType: String, Codable {
  case song = "songs"
  case musicVideo = "music-videos"
  case libraryMusicVideo = "library-music-videos"
  case librarySong = "library-songs"
}
