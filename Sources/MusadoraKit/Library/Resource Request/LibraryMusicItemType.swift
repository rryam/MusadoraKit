//
//  LibraryMusicItemType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

public enum LibraryMusicItemType: String, Codable {
  case songs
  case playlists
  case albums
  case artists
  case musicVideos = "music-videos"

  public var type: String {
    "ids[\(rawValue)]".removingPercentEncoding!
  }
}

extension LibraryMusicItemType {
  static func path(for item: any FilterableLibraryItem.Type) throws -> Self {
    let path: LibraryMusicItemType

    switch item {
      case is Song.Type: path = .songs
      case is Album.Type: path = .albums
      case is Artist.Type: path = .artists
      case is MusicVideo.Type: path = .musicVideos
      case is Playlist.Type: path = .playlists
      default: throw NSError(domain: "Wrong library music item type.", code: 0)
    }
    
    return path
  }
}
