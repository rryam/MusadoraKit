//
//  MusadoraLabsKit.swift
//  MusadoraLabsKit
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

public struct MusadoraLabsKit {
    var library: LibraryPath
    var path: String
    var queryItems: [URLQueryItem]?
    var storeFront: String?

    init(library: LibraryPath, path: String, storeFront: String? = nil, queryItems: [URLQueryItem]? = nil) {
        self.library = library
        self.path = path
        self.queryItems = queryItems
        self.storeFront = storeFront
    }

    init(library: LibraryPath, path: MusicItemPath, storeFront: String? = nil, queryItems: [URLQueryItem]? = nil) {
        self.library = library
        self.path = path.rawValue
        self.queryItems = queryItems
        self.storeFront = storeFront
    }
}
