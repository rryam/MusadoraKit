//
//  LibraryPath.swift
//  LibraryPath
//
//  Created by Rudrank Riyam on 14/08/21.
//

import Foundation

public enum LibraryPath {
  case catalog
  case user
  case library

  var path: String {
    switch self {
    case .catalog: return "/v1/catalog/"
    case .user: return "/v1/me/"
    case .library: return "/v1/me/library/"
    }
  }
}

public enum MusicItemPath: String {
  case albums
  case songs
  case artists
  case playlists
  case musicVideos = "music-videos"

  func id(_ id: String) -> String {
    rawValue + "/" + id
  }
}
