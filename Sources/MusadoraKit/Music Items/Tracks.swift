//
//  Tracks.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 26/12/22.
//

/// A typealias representing a collection of `Track` items.
///
/// This type allows you to work with a group of `Track` objects in the context of a music collection.
///
/// Example usage:
///
///     let myTracks: Tracks = fetchTracks()
///     print(myTracks.count)
///
/// **Note:** This is built on top of `MusicItemCollection`, which provides a generic mechanism to work with music items.
public typealias Tracks = MusicItemCollection<Track>
