//
//  SongsEndpoint.swift
//  SongsEndpoint
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

extension MusadoraLabsKit {
  // MARK: - Catalog Songs

  static func catalogSong(id: String, storeFront: String? = nil) async throws -> URL {
    try await MusadoraLabsKit(library: .catalog, path: MusicItemPath.songs.id(id), storeFront: storeFront).url
  }

  static func catalogSongs(ids: [String], storeFront: String? = nil) async throws -> URL {
    let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
    return try await MusadoraLabsKit(library: .catalog, path: .songs, storeFront: storeFront, queryItems: [query]).url
  }

  static func catalogSongs(isrcs: [String], storeFront: String? = nil) async throws -> URL {
    let query = URLQueryItem(name: "filter[isrc]", value: isrcs.joined(separator: ","))
    return try await MusadoraLabsKit(library: .catalog, path: .songs, storeFront: storeFront, queryItems: [query]).url
  }

  // MARK: - Library Songs

  static func librarySong(id: String) async throws -> URL {
    try await MusadoraLabsKit(library: .library, path: MusicItemPath.songs.id(id)).url
  }

  static func librarySongs(ids: [String]) async throws -> URL {
    let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
    return try await MusadoraLabsKit(library: .library, path: .songs, queryItems: [query]).url
  }

  static func librarySongs() async throws -> URL {
    try await MusadoraLabsKit(library: .library, path: .songs).url
  }
}
