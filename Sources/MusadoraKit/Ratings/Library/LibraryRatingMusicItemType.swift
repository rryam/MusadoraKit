//
//  LibraryRatingMusicItemType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

/// The type of library music item that can be rated.
public enum LibraryRatingMusicItemType: String, Codable {
  /// A song in the user's library.
  case song = "library-songs"
  /// An album in the user's library.
  case album = "library-albums"
  /// A music video in the user's library.
  case musicVideo = "library-music-videos"
  /// A playlist in the user's library.
  case playlist = "library-playlists"
}
