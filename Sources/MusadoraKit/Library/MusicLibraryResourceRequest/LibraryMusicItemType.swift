//
//  LibraryMusicItemType.swift
//  LibraryMusicItemType
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
