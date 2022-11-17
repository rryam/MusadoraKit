//
//  CatalogRatingMusicItemType.swift
//  CatalogRatingMusicItemType
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

public enum CatalogRatingMusicItemType: String, Codable {
  case song = "songs"
  case playlist = "playlist"
  case album = "albums"
  case station = "station"
  case musicVideo = "music-videos"
}
