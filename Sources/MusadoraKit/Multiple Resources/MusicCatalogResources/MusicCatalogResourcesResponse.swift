//
//  MusicCatalogResourcesResponse.swift
//  MusicCatalogResourcesResponse
//
//  Created by Rudrank Riyam on 23/04/22.
//

import MusicKit

/// An object that contains results for a catalog resources request.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
public struct MusicCatalogResourcesResponse {
  /// A collection of stations.
  public var stations: Stations {
    MusicItemCollection(items.compactMap { item in
      guard case let .station(station) = item else { return nil }
      return station
    })
  }

  /// A collection of genres.
  public var genres: Genres {
    MusicItemCollection(items.compactMap { item in
      guard case let .genre(genre) = item else { return nil }
      return genre
    })
  }

  /// A collection of recordLabels.
  public var recordLabels: RecordLabels {
    MusicItemCollection(items.compactMap { item in
      guard case let .recordLabel(recordLabel) = item else { return nil }
      return recordLabel
    })
  }

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

  /// A collection of curators.
  public var curators: Curators {
    MusicItemCollection(items.compactMap { item in
      guard case let .curator(curator) = item else { return nil }
      return curator
    })
  }

  /// A collection of radio shows.
  public var radioShows: RadioShows {
    MusicItemCollection(items.compactMap { item in
      guard case let .radioShow(radioShow) = item else { return nil }
      return radioShow
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
  var items: MusicCatalogResourcesTypes
}
