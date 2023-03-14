//
//  MLibrarySearchable.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//



/// A protocol for music items that your app can fetch by
/// using a library search request.
public protocol MLibrarySearchable: MusicItem {}

extension MLibrarySearchable {
  static var searchIdentifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
}

extension Song: MLibrarySearchable {}

extension Artist: MLibrarySearchable {}

extension Album: MLibrarySearchable {}

extension MusicVideo: MLibrarySearchable {}

extension Playlist: MLibrarySearchable {}
