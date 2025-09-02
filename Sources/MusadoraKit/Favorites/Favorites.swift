//
//  Favorites.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 09/02/25.
//

import Foundation
@_exported import MusicKit

public extension MCatalog {

  // MARK: - Convenience Methods

  /// Add a song to the user's favorites.
  ///
  /// - Parameter song: The song to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(song: Song) async throws -> Bool {
    let request = MFavoritesRequest(itemID: song.id)
    return try await request.response()
  }

  /// Add an album to the user's favorites.
  ///
  /// - Parameter album: The album to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(album: Album) async throws -> Bool {
    let request = MFavoritesRequest(itemID: album.id)
    return try await request.response()
  }

  /// Add a playlist to the user's favorites.
  ///
  /// - Parameter playlist: The playlist to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(playlist: Playlist) async throws -> Bool {
    let request = MFavoritesRequest(itemID: playlist.id)
    return try await request.response()
  }

  /// Add an artist to the user's favorites.
  ///
  /// - Parameter artist: The artist to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(artist: Artist) async throws -> Bool {
    let request = MFavoritesRequest(itemID: artist.id)
    return try await request.response()
  }

  /// Add a music video to the user's favorites.
  ///
  /// - Parameter musicVideo: The music video to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(musicVideo: MusicVideo) async throws -> Bool {
    let request = MFavoritesRequest(itemID: musicVideo.id)
    return try await request.response()
  }

  /// Add a station to the user's favorites.
  ///
  /// - Parameter station: The station to add to favorites.
  /// - Returns: A boolean value indicating whether the operation was successful.
  @discardableResult static func favorite(station: Station) async throws -> Bool {
    let request = MFavoritesRequest(itemID: station.id)
    return try await request.response()
  }

}
