// 
//  LibraryGenre.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 29/07/23.
//

import Foundation

public extension MLibrary {
  /// Fetch all genres from the user's library.
  ///
  /// Use this method to retrieve all the genres present in the user's music library. Example of the genres are Alternative, Rock, etc.
  ///
  /// Example usage:
  ///
  ///     let genres = try await MLibrary.genres()
  ///     for genre in genres {
  ///         print("Genre: \(genre.name)")
  ///     }
  ///     // ... access other properties
  ///
  /// - Returns: A `Genres` collection containing all the genres present in the user's library.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues or invalid parameters.
  ///
  /// - Note: This method fetches the genres locally from the device,
  ///   and is faster because it uses the latest `MusicLibraryRequest` structure.
  @available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
  static func genres() async throws -> Genres {
    let request = MusicLibraryRequest<Genre>()
    let response = try await request.response()
    return response.items
  }
}
