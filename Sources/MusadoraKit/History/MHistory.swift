//
//  MHistory.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 15/03/23.
//

import Foundation

/// Structure containing the methods for accessing historical data.
///
/// `MHistory` provides access to a user's music listening history, including
/// recently played items and recently added content.
///
/// Example usage:
/// ```swift
/// // Fetch recently played items
/// let recentlyPlayed = try await MHistory.recentlyPlayed()
/// print(recentlyPlayed.songs)
/// print(recentlyPlayed.albums)
///
/// // Fetch recently added items
/// let recentlyAdded = try await MHistory.recentlyAdded()
/// print(recentlyAdded.playlists)
/// ```
public struct MHistory {
}
