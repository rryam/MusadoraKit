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
  @discardableResult
  static func favorite(song: Song) async throws -> Bool {
    try await addToFavorites(id: song.id, type: .songs)
  }

  /// Add an album to the user's favorites.
  ///
  /// - Parameter album: The album to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult
  static func favorite(album: Album) async throws -> Bool {
    try await addToFavorites(id: album.id, type: .albums)
  }

  /// Add a playlist to the user's favorites.
  ///
  /// - Parameter playlist: The playlist to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult
  static func favorite(playlist: Playlist) async throws -> Bool {
    try await addToFavorites(id: playlist.id, type: .playlists)
  }

  /// Add an artist to the user's favorites.
  ///
  /// - Parameter artist: The artist to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult
  static func favorite(artist: Artist) async throws -> Bool {
    try await addToFavorites(id: artist.id, type: .artists)
  }

  /// Add a music video to the user's favorites.
  ///
  /// - Parameter musicVideo: The music video to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult
  static func favorite(musicVideo: MusicVideo) async throws -> Bool {
    try await addToFavorites(id: musicVideo.id, type: .musicVideos)
  }

  /// Add a station to the user's favorites.
  ///
  /// - Parameter station: The station to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult
  static func favorite(station: Station) async throws -> Bool {
    try await addToFavorites(id: station.id, type: .stations)
  }

  // MARK: - Internal Implementation

  /// Internal method to add a resource to favorites by ID.
  ///
  /// - Parameter id: The identifier of the music item to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult
  internal static func addToFavorites(id: MusicItemID, type: FavoritesResourceType) async throws -> Bool {
    let request = MFavoritesRequest(itemID: id, resourceType: type)
    return try await request.response()
  }
}
