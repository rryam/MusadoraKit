//
//  FilterableLibraryRatingItem.swift
//  FilterableLibraryRatingItem
//
//  Created by Rudrank Riyam on 18/05/22.
//

import MusicKit

/// A declaration of the associated type that contains the set of library music item
/// properties your app uses as a filter for a library rating request.
public protocol FilterableLibraryRatingItem: MusicItem {
  /// The associated type that contains the set of library music item properties
  /// your app uses as a filter for a library rating request.
  associatedtype FilterableLibraryRatingType
}

/// Album properties your app uses as a filter for a library rating request.
public protocol AlbumLibraryRatingFilter {
  /// The unique identifier for the album.
  var id: MusicItemID { get }
}

/// Song properties your app uses as a filter for a library rating request.
public protocol SongLibraryRatingFilter {
  /// The unique identifier for the song.
  var id: MusicItemID { get }
}

/// Playlist properties your app uses as a filter for a library rating request.
public protocol PlaylistLibraryRatingFilter {
  /// The unique identifier for the playlist.
  var id: MusicItemID { get }
}

/// Music video properties your app uses as a filter for a library rating request.
public protocol MusicVideoLibraryRatingFilter {
  /// The unique identifier for the music video.
  var id: MusicItemID { get }
}

/// Album properties your app uses as a filter for a library rating request.
extension Album: FilterableLibraryRatingItem {
  /// The associated type that contains the set of album properties
  /// your app uses as a filter for a library rating request.
  public typealias FilterableLibraryRatingType = AlbumLibraryRatingFilter
}

extension Playlist: FilterableLibraryRatingItem {
  /// The associated type that contains the set of playlist properties
  /// your app uses as a filter for a library rating request.
  public typealias FilterableLibraryRatingType = PlaylistLibraryRatingFilter
}

extension Song: FilterableLibraryRatingItem {
  /// The associated type that contains the set of song properties
  /// your app uses as a filter for a library rating request.
  public typealias FilterableLibraryRatingType = SongLibraryRatingFilter
}

extension MusicVideo: FilterableLibraryRatingItem {
  /// The associated type that contains the set of music video properties
  /// your app uses as a filter for a library rating request.
  public typealias FilterableLibraryRatingType = MusicVideoLibraryRatingFilter
}
