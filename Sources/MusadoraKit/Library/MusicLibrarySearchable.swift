//
//  MLibrarySearchable.swift
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
///     if let searchableItem = someMusicItem as? MLibrarySearchable {
///         let identifier = searchableItem.searchIdentifier
///     }
///
public protocol MLibrarySearchable: MusicItem {}

extension MLibrarySearchable {

  /// A unique identifier associated with the type that conforms to `MLibrarySearchable`.
  ///
  /// This identifier can be useful for distinguishing different types of music items during search operations or other tasks.
  static var searchIdentifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
}

/// `Song` conformance to `MLibrarySearchable`, allowing songs to be fetched using library search requests.
extension Song: MLibrarySearchable {}

/// `Artist` conformance to `MLibrarySearchable`, allowing artists to be fetched using library search requests.
extension Artist: MLibrarySearchable {}

/// `Album` conformance to `MLibrarySearchable`, allowing albums to be fetched using library search requests.
extension Album: MLibrarySearchable {}

/// `MusicVideo` conformance to `MLibrarySearchable`, allowing music videos to be fetched using library search requests.
extension MusicVideo: MLibrarySearchable {}

/// `Playlist` conformance to `MLibrarySearchable`, allowing playlists to be fetched using library search requests.
extension Playlist: MLibrarySearchable {}
