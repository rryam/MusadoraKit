//
//  LibraryAlbum.swift
//  LibraryAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MusadoraKit {
    static func libraryAlbums() async throws -> Albums {
        try await self.decode(endpoint: .libraryAlbums)
    }
    
    static func recentlyPlayed() async throws -> Songs {
        try await self.decode(endpoint: .recentlyPlayed)
    }
    
    static func heavyRotation() async throws -> Albums {
        try await self.decode(endpoint: .heavyRotation)
    }

    static func recommendations(limit: Int? = nil) async throws -> Recommendations {
        var request = MusicRecommendationRequest()
        request.limit = limit
        let response = try await request.response()
        return response.items
    }
}
