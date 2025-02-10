//
//  MLibrary.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 24/12/22.
//

import Foundation

/// Structure containing the methods related to the user's library.
///
/// `MLibrary` provides comprehensive access to a user's Apple Music library,
/// including methods to fetch, search, and manage library content.
///
/// Example usage:
/// ```swift
/// // Fetch all library songs
/// let songs = try await MLibrary.songs()
///
/// // Search the library
/// let searchResults = try await MLibrary.search(for: "coldplay", types: [Song.self])
///
/// // Add a playlist to library
/// try await MLibrary.addPlaylist(name: "My Playlist", description: "My favorite songs")
/// ```
public struct MLibrary {
}
