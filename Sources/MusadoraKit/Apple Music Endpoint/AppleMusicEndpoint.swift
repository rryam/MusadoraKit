//
//  AppleMusicEndpoint.swift
//  AppleMusicEndpoint
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation
import StoreKit

struct AppleMusicEndpoint {
    var library: LibraryPath?
    var path: String
    var queryItems: [URLQueryItem]?
    
    init(library: LibraryPath, path: String, queryItems: [URLQueryItem]? = nil) {
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
            components.path = library.url
            
            if let queryItems = queryItems {
                components.queryItems = queryItems
            }
            
            switch library {
                case .catalog:https://api.music.apple.com/v1/catalog/{storefront}/albums/{id}
                    let storeFront = try await SKCloudServiceController().requestStorefrontCountryCode()
                    components.path += (storeFront + "/" + path)
                case .user: components.path += path
                case .none: break
            }
            
            guard let url = components.url else {
                preconditionFailure("Invalid URL components: \(components)")
            }
            return url
        }
    }
}
