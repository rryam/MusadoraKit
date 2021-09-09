//
//  AppleMusicEndpoint.swift
//  AppleMusicEndpoint
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation
import MusicKit

public struct AppleMusicEndpoint {
    var library: LibraryPath?
    var path: String
    var queryItems: [URLQueryItem]?
    
    public init(library: LibraryPath? = nil, _ path: String, queryItems: [URLQueryItem]? = nil) {
        self.library = library
        self.path = path
        self.queryItems = queryItems
    }
}

extension AppleMusicEndpoint {
    var url: URL {
        get async throws {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = library?.url ?? ""
            
            if let queryItems = queryItems {
                components.queryItems = queryItems
            }
            
            switch library {
                case .catalog:
                    let storeFront = try await MusicDataRequest.currentCountryCode
                    components.path += (storeFront + "/" + path)
                    
                case .user: components.path += path
                case .none: break
            }
            
            guard let url = components.url else {
                preconditionFailure("Invalid URL components: \(components)")
            }
            
            debugPrint("Apple Music URL is \(url)")
            
            return url
        }
    }
}
