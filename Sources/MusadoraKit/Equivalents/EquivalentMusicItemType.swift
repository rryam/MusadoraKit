//
//  EquivalentMusicItemType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation
import MusicKit

enum EquivalentMusicItemType: String, Codable {
  case songs
  case albums
  case musicVideos = "music-videos"
}

extension EquivalentMusicItemType {
  static func path(for item: EquivalentRequestable.Type) throws -> Self {
    let path: EquivalentMusicItemType

    switch item {
      case is Song.Type: path = .songs
      case is Album.Type: path = .albums
      case is MusicVideo.Type: path = .musicVideos
      default: throw NSError(domain: "Wrong equivalent music item type.", code: 0)
    }
    return path
  }
}
