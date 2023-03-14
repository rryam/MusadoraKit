//
//  MusicLibraryResourcesResponse.swift
//
//
//  Created by Rudrank Riyam on 23/04/22.
//



/// An object that contains results for a catalog resources request.
public struct MusicLibraryResourcesResponse {
  /// A collection of playlists.
  public var playlists: Playlists {
    MusicItemCollection(items.compactMap { item in
      guard case let .playlist(playlist) = item else { return nil }
      return playlist
    })
  }

  /// A collection of artists.
  public var artists: Artists {
    MusicItemCollection(items.compactMap { item in
      guard case let .artist(artist) = item else { return nil }
      return artist
    })
  }

  /// A collection of albums.
  public var albums: Albums {
    MusicItemCollection(items.compactMap { item in
      guard case let .album(album) = item else { return nil }
      return album
    })
  }

  /// A collection of music videos.
  public var musicVideos: MusicVideos {
    MusicItemCollection(items.compactMap { item in
      guard case let .musicVideo(musicVideo) = item else { return nil }
      return musicVideo
    })
  }

  /// A collection of songs.
  public var songs: Songs {
    MusicItemCollection(items.compactMap { item in
      guard case let .song(song) = item else { return nil }
      return song
    })
  }

  /// A collection of different music items.
  var items: MusicLibraryResourcesTypes
}
