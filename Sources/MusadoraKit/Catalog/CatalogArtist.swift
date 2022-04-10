//
//  CatalogArtist.swift
//  CatalogArtist
//
//  Created by Rudrank Riyam on 25/08/21.
//

import MusicKit

/// A collection of artists.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public typealias Artists = MusicItemCollection<Artist>

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MusadoraKit {

    /// Fetch an artist from the Apple Music catalog by using its identifier.
    /// - Parameters:
    ///   - id: The unique identifier for the artist.
    ///   - properties: Additional relationships to fetch with the artist.
    /// - Returns: `Artist` matching the given identifier.
    static func catalogArtist(id: MusicItemID,
                              with properties: [PartialMusicAsyncProperty<Artist>] = []) async throws -> Artist {
        var request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: id)
        request.properties = properties
        let response = try await request.response()

        guard let artist = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }
        return artist
    }

    /// Fetch multiple artists from the Apple Music catalog by using their identifiers.
    /// - Parameters:
    ///   - ids: The unique identifiers for the artists.
    ///   - properties: Additional relationships to fetch with the artists.
    /// - Returns: `Artists` matching the given identifiers.
    static func catalogArtists(ids: [MusicItemID],
                               with properties: [PartialMusicAsyncProperty<Artist>] = []) async throws -> Artists {
        var request = MusicCatalogResourceRequest<Artist>(matching: \.id, memberOf: ids)
        request.properties = properties
        let response = try await request.response()
        return response.items
    }
}
