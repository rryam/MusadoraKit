//
//  LibraryAlbum.swift
//  LibraryAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MusadoraKit {

    /// Fetch an album from the user's library by using its identifier.
    /// - Parameters:
    ///   - id: The unique identifier for the album.
    /// - Returns: `Album` matching the given identifier.
    static func libraryAlbum(id: MusicItemID) async throws -> Album {
        let request = MusicLibraryResourceRequest<Album>(matching: \.id, equalTo: id)
        let response = try await request.response()

        guard let album = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }
        return album
    }

    /// Fetch all albums from the user's library in alphabetical order.
    /// - Parameters:
    ///   - limit: The number of albums returned.
    /// - Returns: `Albums` for the given limit.
    static func libraryAlbums(limit: Int? = nil) async throws -> Albums {
        var request = MusicLibraryResourceRequest<Album>()
        request.limit = limit
        let response = try await request.response()
        return response.items
    }

    /// Fetch multiple albums from the user's library by using their identifiers.
    /// - Parameters:
    ///   - ids: The unique identifiers for the albums.
    /// - Returns: `Albums` matching the given identifiers.
    static func libraryAlbums(ids: [MusicItemID]) async throws -> Albums {
        let request = MusicLibraryResourceRequest<Album>(matching: \.id, memberOf: ids)
        let response = try await request.response()
        return response.items
    }
}
