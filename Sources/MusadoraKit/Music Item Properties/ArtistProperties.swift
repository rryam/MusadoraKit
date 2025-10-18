//
//  ArtistProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// Additional property/relationship of an artist.
public typealias ArtistProperty = PartialMusicAsyncProperty<Artist>

/// Additional properties/relationships of an artist.
public typealias ArtistProperties = [ArtistProperty]

public extension ArtistProperties {
  static var all: Self {
    [.genres, .station, .musicVideos, .albums, .playlists, .appearsOnAlbums, .fullAlbums, .featuredAlbums, .liveAlbums, .compilationAlbums, .featuredPlaylists, .latestRelease, .topSongs, .topMusicVideos, .similarArtists, .singles]
  }
}
