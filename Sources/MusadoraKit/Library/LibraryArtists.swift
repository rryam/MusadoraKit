//
//  LibraryArtists.swift
//  LibraryArtists
//
//  Created by Rudrank Riyam on 17/08/21.
//

import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AppleMusicEndpoint {
    static var libraryArtists: Self {
        AppleMusicEndpoint(library: .user, "library/artists")
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MusadoraKit {
    static func libraryArtists() async throws -> Artists {
        try await self.decode(endpoint: .libraryArtists)
    }
}
