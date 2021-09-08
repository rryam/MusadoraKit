//
//  MusicLibrarySearchable.swift
//  MusicLibrarySearchable
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// A protocol for music items that your app can fetch by
/// using a library search request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public protocol MusicLibrarySearchable: MusicItem {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Song: MusicLibrarySearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Artist: MusicLibrarySearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Album: MusicLibrarySearchable {
    
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension MusicVideo: MusicLibrarySearchable {
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Playlist: MusicLibrarySearchable {
}
