//
//  FilterableLibraryItem.swift
//  FilterableLibraryItem
//
//  Created by Rudrank Riyam on 02/04/22.
//

import MusicKit

/// A declaration of the associated type that contains the set of library music item
/// properties your app uses as a filter for a library resource request.
public protocol FilterableLibraryItem: MusicItem, Decodable {
  /// The associated type that contains the set of library music item properties
  /// your app uses as a filter for a library resource request.
  associatedtype FilterLibraryType
}

/// Album properties your app uses as a filter for a library resource request.
public protocol AlbumLibraryFilter {
  /// The unique identifier for the album.
  var id: MusicItemID { get }
}

/// Song properties your app uses as a filter for a library resource request.
public protocol SongLibraryFilter {
  /// The unique identifier for the song.
  var id: MusicItemID { get }
}

/// Artist properties your app uses as a filter for a library resource request.
public protocol ArtistLibraryFilter {
  /// The unique identifier for the artist.
  var id: MusicItemID { get }
}

/// Playlist properties your app uses as a filter for a library resource request.
public protocol PlaylistLibraryFilter {
  /// The unique identifier for the playlist.
  var id: MusicItemID { get }
}

/// Music video properties your app uses as a filter for a library resource request.
public protocol MusicVideoLibraryFilter {
  /// The unique identifier for the music video.
  var id: MusicItemID { get }
}

/// Album properties your app uses as a filter for a library resource request.
extension Album: FilterableLibraryItem {
  /// The associated type that contains the set of album properties
  /// your app uses as a filter for a library resource request.
  public typealias FilterLibraryType = AlbumLibraryFilter
}

extension Playlist: FilterableLibraryItem {
  /// The associated type that contains the set of playlist properties
  /// your app uses as a filter for a library resource request.
  public typealias FilterLibraryType = PlaylistLibraryFilter
}

extension Song: FilterableLibraryItem {
  /// The associated type that contains the set of song properties
  /// your app uses as a filter for a library resource request.
  public typealias FilterLibraryType = SongLibraryFilter
}

extension Artist: FilterableLibraryItem {
  /// The associated type that contains the set of artist properties
  /// your app uses as a filter for a library resource request.
  public typealias FilterLibraryType = PlaylistLibraryFilter
}

extension MusicVideo: FilterableLibraryItem {
  /// The associated type that contains the set of music video properties
  /// your app uses as a filter for a library resource request.
  public typealias FilterLibraryType = MusicVideoLibraryFilter
}
