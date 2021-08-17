//
//  LibraryPlaylist.swift
//  LibraryPlaylist
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit
import UIKit
import class UIKit.UIImage

public extension AppleMusicEndpoint {
    static var libraryPlaylists: Self {
        AppleMusicEndpoint(library: .user, "/library/playlists")
    }
}

public extension RRMusicKit {
    static func libraryPlaylists() async throws -> MusicItemCollection<Playlist> {
        try await self.decode(endpoint: .libraryPlaylists)
    }
}
