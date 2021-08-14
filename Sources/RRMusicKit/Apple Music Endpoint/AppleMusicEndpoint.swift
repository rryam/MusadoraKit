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
    var addStoreFront: Bool
    var queryItems: [URLQueryItem]?
    
    public init(library: LibraryPath? = nil, _ path: String, addStoreFront: Bool = true, queryItems: [URLQueryItem]? = nil) {
        self.library = library
        self.path = path
        self.addStoreFront = addStoreFront
        self.queryItems = queryItems
    }
}

public extension AppleMusicEndpoint {
    func url() async -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.music.apple.com"
        components.path = library?.url ?? ""
        
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
        
        let storeFront = try? await MusicDataRequest.currentCountryCode
        
        debugPrint("Country Code is \(String(describing: storeFront))")

        if addStoreFront, let storeFront = storeFront {
            components.path += (storeFront + "/" + path)
        } else {
            components.path += path
        }
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        debugPrint("Apple Music URL is \(url)")
        
        return url
    }
}

// MARK: - CATALOG
public extension AppleMusicEndpoint {
    static var genres: Self {
        AppleMusicEndpoint(library: .catalog, "genres")
    }
    
    static var search: Self {
        AppleMusicEndpoint(library: .catalog, "search")
    }
    
    static func hints(storeFront: String) -> Self {
        AppleMusicEndpoint(library: .catalog, "hints")
    }
    
    static var recent: Self {
        AppleMusicEndpoint(library: .user, "recent/played/tracks", addStoreFront: false)
    }
}
