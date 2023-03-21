//
//  MusicVideoProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// Additional property/relationship of a music video.
public typealias MusicVideoProperty = PartialMusicAsyncProperty<MusicVideo>

/// Additional properties/relationships of a music video.
public typealias MusicVideoProperties = [MusicVideoProperty]

extension MusicVideoProperties {
  public static var all: Self {
    [.albums, .genres, .artists, .artistURL, .moreInGenre, .songs, .moreByArtist]
  }
}
