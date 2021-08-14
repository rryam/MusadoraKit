//
//  LibrarySong.swift
//  LibrarySong
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

 extension AppleMusicEndpoint {
    static func librarySong(id: String) -> Self {
        AppleMusicEndpoint(library: .user, "/library/songs/\(id)", addStoreFront: false)
    }
    
    static var librarySongs: Self {
        AppleMusicEndpoint(library: .user, "/library/songs", addStoreFront: false)
    }
    
    static var userLibrary: Self {
        AppleMusicEndpoint(library: .user, "library", addStoreFront: false)
    }
}

public extension RRMusicKit {
    static func librarySongs() async throws -> MusicItemCollection<Song> {
        try await self.decode(endpoint: .librarySongs)
    }
}
