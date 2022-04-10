//
//  CatalogGenre.swift
//  CatalogGenre
//
//  Created by Rudrank Riyam on 17/08/21.
//

import Foundation
import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AppleMusicEndpoint {
    static var genres: Self {
        AppleMusicEndpoint(library: .catalog, "genres")
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MusadoraKit {
    static func genres() async throws -> MusicItemCollection<Genre> {
        try await self.decode(endpoint: .genres)
    }
}
