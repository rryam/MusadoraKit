//
//  CatalogRatingMusicItemType.swift
//  CatalogRatingMusicItemType
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

public enum CatalogRatingMusicItemType: String, Codable {
    case songs
    case playlists
    case albums
    case stations
    case musicVideos = "music-videos"
}
