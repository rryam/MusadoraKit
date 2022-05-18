//
//  LibraryRatingMusicItemType.swift
//  LibraryRatingMusicItemType
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

public enum LibraryRatingMusicItemType: String, Codable {
    case songs = "library-songs"
    case albums = "library-albums"
    case musicVideos = "library-music-videos"
    case playlists = "library-playlists"
}
