//
//  SongsGenres.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 01/08/23.
//

/// A type alias representing a collection of songs for multiple genres.
///
/// This alias is used to manage and manipulate a collection of `SongsForGenre` items.
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.2, visionOS 1.0, *)
public typealias SongsForGenres = [MusicLibrarySection<Genre, Song>]
