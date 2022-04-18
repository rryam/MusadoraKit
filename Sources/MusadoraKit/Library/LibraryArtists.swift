//
//  LibraryArtists.swift
//  LibraryArtists
//
//  Created by Rudrank Riyam on 17/08/21.
//

import MusicKit

public extension MusadoraKit {

    /// Fetch an artist from the user's library by using its identifier.
    /// - Parameters:
    ///   - id: The unique identifier for the artist.
    /// - Returns: `Artist` matching the given identifier.
    static func libraryArtist(id: MusicItemID) async throws -> Artist {
        let request = MusicLibraryResourceRequest<Artist>(matching: \.id, equalTo: id)
        let response = try await request.response()

        guard let artist = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }
        return artist
    }

    /// Fetch all artists from the user's library in alphabetical order.
    /// - Parameters:
    ///   - limit: The number of artists returned.
    /// - Returns: `Artists` for the given limit.
    static func libraryArtists(limit: Int? = nil) async throws -> Artists {
        var request = MusicLibraryResourceRequest<Artist>()
        request.limit = limit
        let response = try await request.response()
        return response.items
    }

    /// Fetch multiple artists from the user's library by using their identifiers.
    /// - Parameters:
    ///   - ids: The unique identifiers for the artists.
    /// - Returns: `Artists` matching the given identifiers.
    static func libraryArtists(ids: [MusicItemID]) async throws -> Artists {
        let request = MusicLibraryResourceRequest<Artist>(matching: \.id, memberOf: ids)
        let response = try await request.response()
        return response.items
    }
}
