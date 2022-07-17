//
//  LibrarySong.swift
//  LibrarySong
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit
import MediaPlayer

public extension MusadoraKit {
  /// Fetch a song from the user's library by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  /// - Returns: `Song` matching the given identifier.
  static func librarySong(id: MusicItemID) async throws -> Song {
    let request = MusicLibraryResourceRequest<Song>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let song = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return song
  }

  /// Fetch all songs from the user's library in alphabetical order.
  /// - Parameters:
  ///   - limit: The number of songs returned.
  /// - Returns: `Songs` for the given limit.
  static func librarySongs(limit: Int? = nil) async throws -> Songs {
    var request = MusicLibraryResourceRequest<Song>()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple songs from the user's library by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func librarySongs(ids: [MusicItemID]) async throws -> Songs {
    let request = MusicLibraryResourceRequest<Song>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return response.items
  }

  static var librarySongsCount: Int {
    get async throws {
      //      if #available(iOS 16, tvOS 16.0, watchOS 9.0, *) {
      //        let request = MusicLibraryRequest<Song>()
      //        let response = try await request.response()
      //        return response.items.count
      //      } else {
      if let items = MPMediaQuery.songs().items {
        return items.count
      } else {
        throw MediaPlayError.notFound(for: "songs")
      }
      //    }
    }
  }
}
