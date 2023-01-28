//
//  LibraryPlaylistCreationRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 28/01/23.
//

import Foundation
import MusicKit

struct LibraryPlaylistCreationRequest: Codable {
  /// A dictionary that includes strings for the name and description of the new playlist.
  var attributes: PlaylistCreationAttributes

  /// To include tracks for the new playlist.
  var relationships: PlaylistCreationRelationships?
}

struct PlaylistCreationAttributes: Codable {
  /// The name of the playlist.
  var name: String

  /// The description of the playlist.
  var description: String?
}

struct PlaylistCreationRelationships: Codable {
  var tracks: PlaylistCreationTracks
}

struct PlaylistCreationTracks: Codable {
  /// Data of the tracks to add to the created library playlist.
  var data: [PlaylistCreationData]
}

struct PlaylistCreationData: Codable {
  /// The unique identifier for the track.
  /// This ID can be a catalog identifier or a library identifier, depending on the track type.
  var id: String

  /// The type of the track to be added.
  var type: LibraryPlaylistCreationTrackType
}

public protocol PlaylistAddable: MusicItem {

  /// The parameters to use to play the item.
  var playParameters: PlayParameters? { get }
}

extension Song: PlaylistAddable { }

extension Track: PlaylistAddable { }

extension MusicVideo: PlaylistAddable { }

public struct MusicPlayParameters: Codable {
  public var id: MusicItemID
  public var isLibrary: Bool?
  public var kind: String
  public var catalogId: MusicItemID?
  public var globalId: MusicItemID?
}

enum LibraryPlaylistCreationTrackType: String, Codable {
  case song = "songs"
  case musicVideo = "music-videos"
  case libraryMusicVideo = "library-music-videos"
  case librarySong = "library-songs"
}
