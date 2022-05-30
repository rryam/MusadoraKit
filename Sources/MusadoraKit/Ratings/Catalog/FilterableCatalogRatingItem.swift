//
//  FilterableCatalogRatingItem.swift
//  FilterableCatalogRatingItem
//
//  Created by Rudrank Riyam on 18/05/22.
//

import MusicKit

/// A declaration of the associated type that contains the set of library music item
/// properties your app uses as a filter for a catalog rating request.
public protocol FilterableCatalogRatingItem: MusicItem {
  /// The associated type that contains the set of library music item properties
  /// your app uses as a filter for a catalog rating request.
  associatedtype FilterableCatalogRatingType
}

/// Album property your app uses as a filter for a catalog rating request.
public protocol AlbumCatalogRatingFilter {
  /// The unique identifier for the album.
  var id: MusicItemID { get }
}

/// Song property your app uses as a filter for a catalog rating request.
public protocol SongCatalogRatingFilter {
  /// The unique identifier for the song.
  var id: MusicItemID { get }
}

/// Station property your app uses as a filter for a catalog rating request.
public protocol StationCatalogRatingFilter {
  /// The unique identifier for the artist.
  var id: MusicItemID { get }
}

/// Playlist property your app uses as a filter for a catalog rating request.
public protocol PlaylistCatalogRatingFilter {
  /// The unique identifier for the playlist.
  var id: MusicItemID { get }
}

/// Music video property your app uses as a filter for a catalog rating request.
public protocol MusicVideoCatalogRatingFilter {
  /// The unique identifier for the music video.
  var id: MusicItemID { get }
}

extension Album: FilterableCatalogRatingItem {
  /// The associated type that contains the album property
  /// your app uses as a filter for a catalog rating request.
  public typealias FilterableCatalogRatingType = AlbumCatalogRatingFilter
}

extension Playlist: FilterableCatalogRatingItem {
  /// The associated type that contains the playlist property
  /// your app uses as a filter for a catalog rating request.
  public typealias FilterableCatalogRatingType = PlaylistCatalogRatingFilter
}

extension Song: FilterableCatalogRatingItem {
  /// The associated type that contains the song property
  /// your app uses as a filter for a catalog rating request.
  public typealias FilterableCatalogRatingType = SongCatalogRatingFilter
}

extension Station: FilterableCatalogRatingItem {
  /// The associated type that contains the station property
  /// your app uses as a filter for a catalog rating request.
  public typealias FilterableCatalogRatingType = StationCatalogRatingFilter
}

extension MusicVideo: FilterableCatalogRatingItem {
  /// The associated type that contains the music video property
  /// your app uses as a filter for a catalog rating request.
  public typealias FilterableCatalogRatingType = MusicVideoCatalogRatingFilter
}
