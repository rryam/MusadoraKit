//
//  MusicLibrarySearchType.swift
//  MusicLibrarySearchType
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

enum MusicLibrarySearchType: String, CodingKey {
    case songs = "library-songs"
    case artists = "library-artists"
    case albums = "library-albums"
    case musicVideos = "library-music-videos"
    case playlists = "library-playlists"

    static func getTypes(_ types: [MusicLibrarySearchable.Type]) -> String {
        Set(types.map({ $0.searchIdentifier })).compactMap {
            switch $0 {
                case Song.searchIdentifier: return songs.rawValue
                case Album.searchIdentifier: return albums.rawValue
                case MusicVideo.searchIdentifier: return musicVideos.rawValue
                case Playlist.searchIdentifier: return playlists.rawValue
                case Artist.searchIdentifier: return artists.rawValue
                default: return nil
            }
        }.joined(separator: ",")
    }
}
