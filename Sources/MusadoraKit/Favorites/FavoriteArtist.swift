//
//  FavoriteArtist.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation
import MusicKit

extension MCatalog {
  /// Mark an artist as favorite for the User.
  ///
  /// This function is marked as @discardableResult, which means that the return value can be ignored without causing any consequences.
  /// However, it is recommended to handle the return value in order to handle any potential errors or failures.
  ///
  ///     let artist = ...
  ///     do {
  ///       let result = try await MCatalog.favorite(artist: artist)
  ///
  ///       if result {
  ///         // The artist was successfully marked as favorite
  ///       } else {
  ///         // There was a problem marking the artist as favorite
  ///       }
  ///     } catch {
  ///         // An error occurred while processing the request
  ///     }
  ///
  /// - Parameters:
  ///    - artist: The artist  to mark as favorite.
  /// - Returns: A boolean value indicating the success or failure of marking the artist as favorite.
  @available(*, message: "THIS IS A PRIVATE ENDPOINT. USE IT AT YOUR OWN RISK.")
  @discardableResult static func favorite(artist: Artist) async throws -> Bool {
    let request = MFavoritesRequest(artist: artist, type: .favorite)
    let response = try await request.response()
    return response
  }

  /// Remove the artist as favorite for the User.
  ///
  /// This function is marked as @discardableResult, which means that the return value can be ignored without causing any consequences.
  /// However, it is recommended to handle the return value in order to handle any potential errors or failures.
  ///
  ///     let artist = ...
  ///     do {
  ///       let result = try await MCatalog.removeFavorite(artist: artist)
  ///
  ///       if result {
  ///         // The artist was successfully removed as favorite
  ///       } else {
  ///         // There was a problem removing the artist from favorite
  ///       }
  ///     } catch {
  ///         // An error occurred while processing the request
  ///     }
  ///
  /// - Parameters:
  ///    - artist: The artist  to remove from favorite.
  /// - Returns: A boolean value indicating the success or failure of removing the artist from favorite.
  @available(*, message: "THIS IS A PRIVATE ENDPOINT. USE IT AT YOUR OWN RISK.")
  @discardableResult static func removeFavorite(artist: Artist) async throws -> Bool {
    let request = MFavoritesRequest(artist: artist, type: .removeFavorite)
    let response = try await request.response()
    return response
  }
}

