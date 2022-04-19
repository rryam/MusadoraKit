//
//  PlaylistsEndpoint.swift
//  PlaylistsEndpoint
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

extension MusadoraLabsKit {
    // MARK: - Catalog Playlists
    static func catalogPlaylist(id: String, storeFront: String? = nil) async throws -> URL {
        try await MusadoraLabsKit(library: .catalog, path: MusicItemPath.playlists.id(id), storeFront: storeFront).url
    }

    static func catalogPlaylists(ids: [String], storeFront: String? = nil) async throws -> URL {
        let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
        return try await MusadoraLabsKit(library: .catalog, path: .playlists, storeFront: storeFront, queryItems: [query]).url
    }

    // MARK: - Library Playlists
    static func libraryPlaylist(id: String) async throws -> URL {
        try await MusadoraLabsKit(library: .library, path: MusicItemPath.playlists.id(id)).url
    }

    static func libraryPlaylists(ids: [String]) async throws -> URL {
        let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
        return try await MusadoraLabsKit(library: .library, path: .playlists, queryItems: [query]).url
    }

    static func libraryPlaylists() async throws -> URL {
        try await MusadoraLabsKit(library: .library, path: .playlists).url
    }
}
