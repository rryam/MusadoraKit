//
//  LibrarySong.swift
//  LibrarySong
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

 extension AppleMusicEndpoint {
    static func librarySong(id: String) -> Self {
        AppleMusicEndpoint(library: .user, "/library/songs/\(id)")
    }
    
    static var librarySongs: Self {
        AppleMusicEndpoint(library: .user, "/library/songs")
    }
    
    static var userLibrary: Self {
        AppleMusicEndpoint(library: .user, "library")
    }
}

public extension RRMusicKit {
    static func librarySongs() async throws -> Songs {
        try await self.decode(endpoint: .librarySongs)
    }
}
