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
    
    var path: String {
        switch self {
            case .catalog: return "/v1/catalog/"
            case .user: return "/v1/me/"
        }
    }
}

public enum MusicItemPath: String {
    case albums
    case songs
    case artists
    case playlists
    case musicVideos = "music-videos"

    var path: String {
        self.rawValue
    }
}
