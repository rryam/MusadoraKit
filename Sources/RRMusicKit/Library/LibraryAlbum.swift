//
//  LibraryAlbum.swift
//  LibraryAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

extension AppleMusicEndpoint {
    static var libraryAlbums: Self {
        AppleMusicEndpoint(library: .user, "library/albums")
    }
    
    static var heavyRotation: Self {
        AppleMusicEndpoint(library: .user, "history/heavy-rotation")
    }
    
    static var recentlyPlayed: Self {
        AppleMusicEndpoint(library: .user, "recent/played/tracks")
    }
    
    static var recommendations: Self {
        AppleMusicEndpoint(library: .user, "recommendations")
    }
}

public extension RRMusicKit {
    static func libraryAlbums() async throws -> MusicItemCollection<Album> {
        try await self.decode(endpoint: .libraryAlbums)
    }
    
    static func recentlyPlayed() async throws -> MusicItemCollection<Song> {
        try await self.decode(endpoint: .recentlyPlayed)
    }
    
    static func heavyRotation() async throws -> MusicItemCollection<Album> {
        try await self.decode(endpoint: .heavyRotation)
    }
    
    #warning("The recommendations API returns a mix of albums and playlists. Need to figure out a way to do that.")
    static func recommendations() async throws -> MusicItemCollection<Album> {
        try await self.decode(endpoint: .recommendations)
    }
}
