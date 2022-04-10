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

public extension MusadoraKit {
    static func librarySong(id: MusicItemID) async throws -> Song {
        let request = MusicLibraryResourceRequest<Song>(matching: \.id, equalTo: id)

        let response = try await request.response()

        guard let song = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }

        return song
    }

    static func librarySongs(limit: Int? = nil) async throws -> Songs {
        var request = MusicLibraryResourceRequest<Song>()
        request.limit = limit

        let response = try await request.response()

        return response.items
    }

    static func librarySongs(ids: [MusicItemID]) async throws -> Songs {
        let request = MusicLibraryResourceRequest<Song>(matching: \.id, memberOf: ids)

        let response = try await request.response()

        return response.items
    }
}
