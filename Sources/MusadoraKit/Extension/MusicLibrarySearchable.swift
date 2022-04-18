//
//  MusicLibrarySearchable.swift
//  MusicLibrarySearchable
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// A protocol for music items that your app can fetch by
/// using a library search request.
public protocol MusicLibrarySearchable: MusicItem {}

extension MusicLibrarySearchable {
    static var searchIdentifier: ObjectIdentifier {
        ObjectIdentifier(Self.self)
    }
}

extension Song: MusicLibrarySearchable {}

extension Artist: MusicLibrarySearchable {}

extension Album: MusicLibrarySearchable {}

extension MusicVideo: MusicLibrarySearchable {}

extension Playlist: MusicLibrarySearchable {}
