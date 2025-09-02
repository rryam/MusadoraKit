//
//  Favorites.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 09/02/25.
//

import Foundation
@_exported import MusicKit

public extension MCatalog {

  /// Add a resource to the user's favorites.
  ///
  /// This method adds the specified music item to the user's favorites.
  /// When successful, the item will appear in the user's favorite items collection
  /// and can be filtered on in their library view.
  ///
  /// Example usage:
  /// ```swift
  /// let success = try await MCatalog.addToFavorites(id: "1234567890")
  /// ```
  ///
  /// - Parameter id: The identifier of the music item to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func addToFavorites(id: MusicItemID) async throws -> Bool {
    let request = MFavoritesRequest(itemID: id)
    return try await request.response()
  }

  /// Add a resource to the user's favorites (singular alias).
  ///
  /// - Parameter id: The identifier of the music item to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func addToFavorite(id: MusicItemID) async throws -> Bool {
    try await addToFavorites(id: id)
  }

  /// Add multiple resources to the user's favorites.
  ///
  /// This method supports bulk additions of heterogeneous types (songs, albums,
  /// playlists, artists, etc.) to the user's favorites in a single request.
  ///
  /// Example usage:
  /// ```swift
  /// let itemIDs = ["song123", "album456", "playlist789"]
  /// let success = try await MCatalog.addToFavorites(ids: itemIDs)
  /// ```
  ///
  /// - Parameter ids: An array of music item identifiers to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func addToFavorites(ids: [MusicItemID]) async throws -> Bool {
    let request = MFavoritesRequest(itemIDs: ids)
    return try await request.response()
  }

  // MARK: - Convenience Methods

  /// Add a song to the user's favorites.
  ///
  /// - Parameter song: The song to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(song: Song) async throws -> Bool {
    try await addToFavorites(id: song.id)
  }

  /// Add an album to the user's favorites.
  ///
  /// - Parameter album: The album to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(album: Album) async throws -> Bool {
    try await addToFavorites(id: album.id)
  }

  /// Add a playlist to the user's favorites.
  ///
  /// - Parameter playlist: The playlist to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(playlist: Playlist) async throws -> Bool {
    try await addToFavorites(id: playlist.id)
  }

  /// Add an artist to the user's favorites.
  ///
  /// - Parameter artist: The artist to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(artist: Artist) async throws -> Bool {
    try await addToFavorites(id: artist.id)
  }

  /// Add a music video to the user's favorites.
  ///
  /// - Parameter musicVideo: The music video to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(musicVideo: MusicVideo) async throws -> Bool {
    try await addToFavorites(id: musicVideo.id)
  }

  /// Add a station to the user's favorites.
  ///
  /// - Parameter station: The station to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(station: Station) async throws -> Bool {
    try await addToFavorites(id: station.id)
  }
}
