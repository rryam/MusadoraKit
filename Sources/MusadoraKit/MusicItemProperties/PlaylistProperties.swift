//
//  PlaylistProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// Additional property/relationship of a playlist.
public typealias PlaylistProperty = PartialMusicAsyncProperty<Playlist>

/// Additional properties/relationships of a playlist.
public typealias PlaylistProperties = [PlaylistProperty]

public extension PlaylistProperties {
  static var all: Self {
    var properties: Self = [.tracks, .featuredArtists, .moreByCurator]

    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      properties += [.curator, .radioShow]
      return properties
    } else {
      return properties
    }
  }
}
