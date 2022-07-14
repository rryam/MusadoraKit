//
//  MusadoraLibrarySearchable.swift
//  MusadoraLibrarySearchable
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// A protocol for music items that your app can fetch by
/// using a library search request.
public protocol MusadoraLibrarySearchable: MusicItem {}

extension MusadoraLibrarySearchable {
  static var searchIdentifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
}

extension Song: MusadoraLibrarySearchable {}

extension Artist: MusadoraLibrarySearchable {}

extension Album: MusadoraLibrarySearchable {}

extension MusicVideo: MusadoraLibrarySearchable {}

extension Playlist: MusadoraLibrarySearchable {}
