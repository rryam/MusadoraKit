//
//  LibraryArtists.swift
//  LibraryArtists
//
//  Created by Rudrank Riyam on 17/08/21.
//

import MusicKit

extension AppleMusicEndpoint {
    static var libraryArtists: Self {
        AppleMusicEndpoint(library: .user, "library/artists")
    }
}

public extension RRMusicKit {
    static func libraryArtists() async throws -> MusicItemCollection<Artist> {
        try await self.decode(endpoint: .libraryArtists)
    }
}
