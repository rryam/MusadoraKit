//
//  MHistoryResponse.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

import MusicKit

/// An object that contains results for a history request.
public struct MHistoryResponse {
  /// A collection of historical resources based on the `MusicHistoryRequest`.
  public let items: UserMusicItems

  /// A collection of historical albums.
  public var albums: Albums {
    MusicItemCollection(items.compactMap { item in
      guard case let .album(album) = item else { return nil }
      return album
    })
  }

  /// A collection of historical playlists.
  public var playlists: Playlists {
    MusicItemCollection(items.compactMap { item in
      guard case let .playlist(playlist) = item else { return nil }
      return playlist
    })
  }

  /// A collection of historical stations.
  public var stations: Stations {
    MusicItemCollection(items.compactMap { item in
      guard case let .station(station) = item else { return nil }
      return station
    })
  }

  /// A collection of historical tracks.
  public var tracks: Tracks {
    MusicItemCollection(items.compactMap { item in
      guard case let .track(track) = item else { return nil }
      return track
    })
  }
}

extension MHistoryResponse: Equatable, Hashable, Codable {}

extension MHistoryResponse: CustomStringConvertible {
  public var description: String {
    "MusicHistoryResponse(\(items.description)"
  }
}
