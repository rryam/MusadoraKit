//
//  MLibrarySearchResponse.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// An object that contains results for a library search request.
public struct MLibrarySearchResponse: Equatable, Hashable, Sendable {
  /// A collection of songs.
  public let songs: Songs

  /// A collection of artists.
  public let artists: Artists

  /// A collection of albums.
  public let albums: Albums

  /// A collection of music videos.
  public let musicVideos: MusicVideos

  /// A collection of playlists.
  public let playlists: Playlists

  public func hash(into hasher: inout Hasher) {
    hasher.combine(self)
  }
}

extension MLibrarySearchResponse: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MLibrarySearchType.self)

    songs = try container.decodeIfPresent(Songs.self, forKey: .songs) ?? []
    artists = try container.decodeIfPresent(Artists.self, forKey: .artists) ?? []
    albums = try container.decodeIfPresent(Albums.self, forKey: .albums) ?? []
    musicVideos = try container.decodeIfPresent(MusicVideos.self, forKey: .musicVideos) ?? []
    playlists = try container.decodeIfPresent(Playlists.self, forKey: .playlists) ?? []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: MLibrarySearchType.self)

    try container.encode(songs, forKey: .songs)
    try container.encode(artists, forKey: .artists)
    try container.encode(albums, forKey: .albums)
    try container.encode(musicVideos, forKey: .musicVideos)
    try container.encode(playlists, forKey: .playlists)
  }
}

extension MLibrarySearchResponse: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    var description = "MusicLibrarySearchResponse("
    let mirror = Mirror(reflecting: self)

    description += mirror.children.map { "\n\($0.value)," }.joined()

    return description + "\n)"
  }

  public var debugDescription: String {
    "MusicLibrarySearchResponse(\n\(songs.debugDescription),\n\(artists.debugDescription),\n\(albums.debugDescription),\n\(musicVideos.debugDescription),\(playlists.debugDescription)\n)"
  }
}
