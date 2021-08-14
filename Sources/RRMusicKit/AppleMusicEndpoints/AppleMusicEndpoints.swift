//
//  AppleMusicEndPoint.swift
//  AppleMusicEndPoint
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation
import MusicKit

public enum LibraryPath: String {
    case catalog
    case user
    
    var url: String {
        switch self {
            case .catalog: return "/v1/catalog/"
            case .user: return "/v1/me/"
        }
    }
}

public struct AppleMusicEndPoint {
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

public extension AppleMusicEndPoint {
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
public extension AppleMusicEndPoint {
    static var genres: Self {
        AppleMusicEndPoint(library: .catalog, "genres")
    }
    
    static var search: Self {
        AppleMusicEndPoint(library: .catalog, "search")
    }
    
    static func hints(storeFront: String) -> Self {
        AppleMusicEndPoint(library: .catalog, "hints")
    }
    
    static var recent: Self {
        AppleMusicEndPoint(library: .user, "recent/played/tracks", addStoreFront: false)
    }
}
