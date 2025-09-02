//
//  Favorites.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 09/02/25.
//

import Foundation

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
}
