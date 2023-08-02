//
//  SongsForPlaylists.swift
//  
//
//  Created by Rudrank Riyam on 02/08/23.
//

import Foundation

/// A type alias representing a collection of songs for multiple playlists.
///
/// This alias is used to manage and manipulate a collection of `SongsForPlaylists` items.
@available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, *)
public typealias SongsForPlaylists = [MusicLibrarySection<Playlist, Song>]
