//
//  CatalogGenre.swift
//  CatalogGenre
//
//  Created by Rudrank Riyam on 17/08/21.
//

import Foundation
import MusicKit

extension AppleMusicEndpoint {
    static var genres: Self {
        AppleMusicEndpoint(library: .catalog, "genres")
    }
}

public extension RRMusicKit {
    static func genres() async throws -> MusicItemCollection<Genre> {
        try await self.decode(endpoint: .genres)
    }
}
