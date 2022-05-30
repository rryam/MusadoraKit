//
//  ArtistsEndpoint.swift
//  ArtistsEndpoint
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

extension MusadoraLabsKit {
  // MARK: - Catalog Artists

  static func catalogArtist(id: String, storeFront: String? = nil) async throws -> URL {
    try await MusadoraLabsKit(library: .catalog, path: MusicItemPath.artists.id(id), storeFront: storeFront).url
  }

  static func catalogArtists(ids: [String], storeFront: String? = nil) async throws -> URL {
    let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
    return try await MusadoraLabsKit(library: .catalog, path: .artists, storeFront: storeFront, queryItems: [query]).url
  }

  // MARK: - Library Artists

  static func libraryArtist(id: String) async throws -> URL {
    try await MusadoraLabsKit(library: .library, path: MusicItemPath.artists.id(id)).url
  }

  static func libraryArtists(ids: [String]) async throws -> URL {
    let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
    return try await MusadoraLabsKit(library: .library, path: .artists, queryItems: [query]).url
  }

  static func libraryArtists() async throws -> URL {
    try await MusadoraLabsKit(library: .library, path: .artists).url
  }
}
