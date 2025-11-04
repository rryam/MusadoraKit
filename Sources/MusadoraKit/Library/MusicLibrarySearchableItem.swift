// 
//  MusicLibrarySearchable.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

/// A protocol representing music items that can be fetched through a library search request.
///
/// Adhere to this protocol to enable library searching functionality for custom music items.
/// By default, the protocol provides a unique identifier for each type that conforms to it.
///
/// Example:
///
///     if let searchableItem = someMusicItem as? MusicLibrarySearchableItem {
///         let identifier = searchableItem.searchIdentifier
///     }
///
public protocol MusicLibrarySearchableItem: MusicItem {}

extension MusicLibrarySearchableItem {
  /// A unique identifier associated with the type that conforms to `MusicLibrarySearchableItem`.
  ///
  /// This identifier can be useful for distinguishing different types of music items during search operations or other tasks.
  static var searchIdentifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
}

/// `Song` conformance to `MusicLibrarySearchableItem`, allowing songs to be fetched using library search requests.
extension Song: MusicLibrarySearchableItem {}

/// `Artist` conformance to `MusicLibrarySearchableItem`, allowing artists to be fetched using library search requests.
extension Artist: MusicLibrarySearchableItem {}

/// `Album` conformance to `MusicLibrarySearchableItem`, allowing albums to be fetched using library search requests.
extension Album: MusicLibrarySearchableItem {}

/// `MusicVideo` conformance to `MusicLibrarySearchableItem`, allowing music videos to be fetched using library search requests.
extension MusicVideo: MusicLibrarySearchableItem {}

/// `Playlist` conformance to `MusicLibrarySearchableItem`, allowing playlists to be fetched using library search requests.
extension Playlist: MusicLibrarySearchableItem {}
