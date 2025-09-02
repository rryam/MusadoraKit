//
//  Favorites.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 09/02/25.
//

import Foundation

public extension MCatalog {

  // MARK: - Public API

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


  // MARK: - Internal Implementation

  /// Internal method to add a resource to favorites by ID.
  ///
  /// - Parameter id: The identifier of the music item to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func addToFavorites(id: MusicItemID) async throws -> Bool {
    let request = MFavoritesRequest(itemID: id)
    return try await request.response()
  }

  

}
