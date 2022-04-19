//
//  AlbumsEndpoint.swift
//  AlbumsEndpoint
//
//  Created by Rudrank Riyam on 18/04/22.
//

import Foundation

public extension MusadoraLabsKit {
    // MARK: - Catalog Albums
    static func catalogAlbum(id: String, storeFront: String? = nil) async throws -> URL {
        try await MusadoraLabsKit(library: .catalog, path: MusicItemPath.albums.id(id), storeFront: storeFront).url
    }

    static func catalogAlbums(ids: [String], storeFront: String? = nil) async throws -> URL {
        let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
        return try await MusadoraLabsKit(library: .catalog, path: .albums, storeFront: storeFront, queryItems: [query]).url
    }

    static func catalogAlbums(upcs: [String], storeFront: String? = nil) async throws -> URL {
        let query = URLQueryItem(name: "filter[upc]", value: upcs.joined(separator: ","))
        return try await MusadoraLabsKit(library: .catalog, path: .albums, storeFront: storeFront, queryItems: [query]).url
    }

    // MARK: - Library Albums
    static func libraryAlbum(id: String) async throws -> URL {
        try await MusadoraLabsKit(library: .library, path: MusicItemPath.albums.id(id)).url
    }

    static func libraryAlbums(ids: [String]) async throws -> URL {
        let query = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
        return try await MusadoraLabsKit(library: .library, path: .albums, queryItems: [query]).url
    }

    static func libraryAlbums() async throws -> URL {
        try await MusadoraLabsKit(library: .library, path: .albums).url
    }
}
