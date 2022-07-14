//
//  MusadoraLibrarySearchResponse.swift
//  MusadoraLibrarySearchResponse
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// An object that contains results for a library search request.
public struct MusadoraLibrarySearchResponse: Equatable, Hashable, Sendable {
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

extension MusadoraLibrarySearchResponse: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MusadoraLibrarySearchType.self)

    songs = try container.decodeIfPresent(Songs.self, forKey: .songs) ?? []
    artists = try container.decodeIfPresent(Artists.self, forKey: .artists) ?? []
    albums = try container.decodeIfPresent(Albums.self, forKey: .albums) ?? []
    musicVideos = try container.decodeIfPresent(MusicVideos.self, forKey: .musicVideos) ?? []
    playlists = try container.decodeIfPresent(Playlists.self, forKey: .playlists) ?? []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: MusadoraLibrarySearchType.self)

    try container.encode(songs, forKey: .songs)
    try container.encode(artists, forKey: .artists)
    try container.encode(albums, forKey: .albums)
    try container.encode(musicVideos, forKey: .musicVideos)
    try container.encode(playlists, forKey: .playlists)
  }
}

extension MusadoraLibrarySearchResponse: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    var description = "MusicLibrarySearchResponse("
    let mirror = Mirror(reflecting: self)

    description += mirror.children.map { "\n\($0.value)," }.joined()

    return description + "\n)"
  }

#warning("Figure out a better way to do this")
  public var debugDescription: String {
    "MusicLibrarySearchResponse(\n\(songs.debugDescription),\n\(artists.debugDescription),\n\(albums.debugDescription),\n\(musicVideos.debugDescription),\(playlists.debugDescription)\n)"
  }
}
