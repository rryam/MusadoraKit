//
//  MCatalog.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

import Foundation

/// Structure containing the methods related to the Apple Music catalog.
///
/// `MCatalog` provides an interface for interacting with the Apple Music catalog.
/// It includes methods for searching, fetching, and managing catalog items like songs, albums, playlists, and more.
///
/// Example usage:
/// ```swift
/// // Fetch a song by its identifier
/// let song = try await MCatalog.song(id: "1613834314")
///
/// // Search the catalog
/// let results = try await MCatalog.search(for: "the weeknd", types: [.songs, .albums])
/// ```
public struct MCatalog {
}
