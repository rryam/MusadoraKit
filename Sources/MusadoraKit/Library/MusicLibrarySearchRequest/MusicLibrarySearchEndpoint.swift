//
//  MusicLibrarySearchEndpoint.swift
//  MusicLibrarySearchEndpoint
//
//  Created by Rudrank Riyam on 08/09/21.
//

import Foundation

public extension AppleMusicEndpoint {
    static func librarySearch(with queryItems: [URLQueryItem]) -> Self {
        AppleMusicEndpoint(library: .user, "library/search", queryItems: queryItems)
    }
}

