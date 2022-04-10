//
//  LibraryPlaylist.swift
//  LibraryPlaylist
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension AppleMusicEndpoint {
    static var libraryPlaylists: Self {
        AppleMusicEndpoint(library: .user, "/library/playlists")
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MusadoraKit {
    static func libraryPlaylists() async throws -> Playlists {
        try await self.decode(endpoint: .libraryPlaylists)
    }
}
