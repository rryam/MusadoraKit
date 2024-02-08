//
//  SongProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// Additional property/relationship of a song.
public typealias SongProperty = PartialMusicAsyncProperty<Song>

/// Additional properties/relationships of a song.
public typealias SongProperties = [SongProperty]

extension SongProperties {
  public static var all: Self {
    var properties: Self = [.albums, .artists, .composers, .genres, .musicVideos, .artistURL, .station]
    
    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      properties += [.audioVariants]
      return properties
    } else {
      return properties
    }
  }
}
