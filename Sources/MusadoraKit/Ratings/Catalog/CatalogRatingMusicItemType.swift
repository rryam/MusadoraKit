//
//  CatalogRatingMusicItemType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// An enumeration of the types of music items that can be rated in the Apple Music Catalog.
public enum CatalogRatingMusicItemType: String, Codable {
  case song = "songs"
  case playlist = "playlists"
  case album = "albums"
  case station = "stations"
  case musicVideo = "music-videos"
}
