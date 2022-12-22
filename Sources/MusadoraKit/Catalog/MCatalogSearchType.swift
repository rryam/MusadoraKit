//
//  MCatalogSearchType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

import MusicKit

public enum MCatalogSearchType {
  case songs
  case albums
  case playlists
  case artists
  case stations
  case recordLabels

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
  case musicVideos, curators, radioShows

  public var type: MusicCatalogSearchable.Type? {
    switch self {
      case .songs:
        return Song.self
      case .albums:
        return Album.self
      case .playlists:
        return Playlist.self
      case .artists:
        return Artist.self
      case .stations:
        return Station.self
      case .recordLabels:
        return RecordLabel.self

      case .musicVideos:
        if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *) {
          return MusicVideo.self
        } else {
          return nil
        }
      case .curators:
        if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *) {
          return Curator.self
        } else {
          return nil
        }
      case .radioShows:
        if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *) {
          return RadioShow.self
        } else {
          return nil
        }
    }
  }
}
