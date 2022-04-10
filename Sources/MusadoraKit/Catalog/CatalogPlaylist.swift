//
//  CatalogPlaylist.swift
//  CatalogPlaylist
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// A collection of playlists.
public typealias Playlists = MusicItemCollection<Playlist>

public extension MusadoraKit {

    /// Fetch a playlist from the Apple Music catalog by using its identifier.
    /// - Parameters:
    ///   - id: The unique identifier for the playlist.
    ///   - properties: Additional relationships to fetch with the playlist.
    /// - Returns: `Playlist` matching the given identifier.
    static func catalogPlaylist(id: MusicItemID,
                                with properties: [PartialMusicAsyncProperty<Playlist>] = []) async throws -> Playlist {
        var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
        request.properties = properties
        let response = try await request.response()

        guard let playlist = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }
        return playlist
    }

    /// Fetch multiple playlists from the Apple Music catalog by using their identifiers.
    /// - Parameters:
    ///   - ids: The unique identifiers for the playlists.
    ///   - properties: Additional relationships to fetch with the playlists.
    /// - Returns: `Playlists` matching the given identifiers.
    static func catalogPlaylists(ids: [MusicItemID],
                                 with properties: [PartialMusicAsyncProperty<Playlist>] = []) async throws -> Playlists {
        var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
        request.properties = properties
        let response = try await request.response()
        return response.items
    }
}
