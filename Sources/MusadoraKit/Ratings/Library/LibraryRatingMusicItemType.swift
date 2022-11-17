//
//  LibraryRatingMusicItemType.swift
//  LibraryRatingMusicItemType
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public enum LibraryRatingMusicItemType: String, Codable {
  case song = "library-songs"
  case album = "library-albums"
  case musicVideo = "library-music-videos"
  case playlist = "library-playlists"
}
