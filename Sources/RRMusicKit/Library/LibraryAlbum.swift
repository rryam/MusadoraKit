//
//  LibraryAlbum.swift
//  LibraryAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

extension AppleMusicEndpoint {
    static var libraryAlbums: Self {
        AppleMusicEndpoint(library: .user, "library/albums", addStoreFront: false)
    }
}

public extension RRMusicKit {
    static func libraryAlbums() async throws -> MusicItemCollection<Album> {
        try await self.decode(endpoint: .libraryAlbums)
    }
}
