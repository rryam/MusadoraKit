//
//  MusicVideosEndpoint.swift
//
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

extension MusadoraLabsKit {
  // MARK: - Catalog Music Videos

  static func catalogMusicVideo(id: String, storeFront: String? = nil) async throws -> URL {
    try await MusadoraLabsKit(library: .catalog, path: MusicItemPath.musicVideos.id(id), storeFront: storeFront).url
  }

  static func catalogMusicVideos(ids: [String], storeFront: String? = nil) async throws -> URL {
    let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
    return try await MusadoraLabsKit(library: .catalog, path: .musicVideos, storeFront: storeFront, queryItems: [query]).url
  }

  static func catalogMusicVideos(isrcs: [String], storeFront: String? = nil) async throws -> URL {
    let query = URLQueryItem(name: "filter[isrc]", value: isrcs.joined(separator: ","))
    return try await MusadoraLabsKit(library: .catalog, path: .musicVideos, storeFront: storeFront, queryItems: [query]).url
  }

  // MARK: - Library Music Videos

  static func libraryMusicVideo(id: String) async throws -> URL {
    try await MusadoraLabsKit(library: .library, path: MusicItemPath.musicVideos.id(id)).url
  }

  static func libraryMusicVideos(ids: [String]) async throws -> URL {
    let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
    return try await MusadoraLabsKit(library: .library, path: .musicVideos, queryItems: [query]).url
  }

  static func libraryMusicVideos() async throws -> URL {
    try await MusadoraLabsKit(library: .library, path: .musicVideos).url
  }
}
