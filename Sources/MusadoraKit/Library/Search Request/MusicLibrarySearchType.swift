//
//  MLibrarySearchType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//



enum MLibrarySearchType: String, CodingKey {
  case songs = "library-songs"
  case artists = "library-artists"
  case albums = "library-albums"
  case musicVideos = "library-music-videos"
  case playlists = "library-playlists"

  static func getTypes(_ types: [MLibrarySearchable.Type]) -> String {
    types
      .map { $0.searchIdentifier }
      .removeDuplicates()
      .compactMap {
        switch $0 {
          case Song.searchIdentifier: return songs.rawValue
          case Album.searchIdentifier: return albums.rawValue
          case MusicVideo.searchIdentifier: return musicVideos.rawValue
          case Playlist.searchIdentifier: return playlists.rawValue
          case Artist.searchIdentifier: return artists.rawValue
          default: return nil
        }
      }
      .joined(separator: ",")
  }
}
