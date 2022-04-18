//
//  AppleMusicEndpoint.swift
//  AppleMusicEndpoint
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation
import MusicKit

public struct AppleMusicEndpoint {
    var library: LibraryPath
    var path: String
    var queryItems: [URLQueryItem]?
    var storeFront: String?
    
    public init(library: LibraryPath, path: String, storeFront: String? = nil, queryItems: [URLQueryItem]? = nil) {
        self.library = library
        self.path = path
        self.queryItems = queryItems
        self.storeFront = storeFront
    }

    public init(library: LibraryPath, path: MusicItemPath, storeFront: String? = nil, queryItems: [URLQueryItem]? = nil) {
        self.library = library
        self.path = path.rawValue
        self.queryItems = queryItems
        self.storeFront = storeFront
    }
}

extension AppleMusicEndpoint {
    public var url: URL {
        get async throws {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = library.path

            if let queryItems = queryItems {
                components.queryItems = queryItems
            }

            switch library {
                case .catalog:
                    if let storeFront = storeFront {
                        components.path += storeFront + "/" + path
                    } else {
                        let storeFront = try await MusicDataRequest.currentCountryCode
                        components.path += storeFront + "/" + path
                    }
                case .user, .library: components.path += path
            }

            guard let url = components.url else {
                preconditionFailure("Invalid URL components: \(components)")
            }
            return url
        }
    }
}
