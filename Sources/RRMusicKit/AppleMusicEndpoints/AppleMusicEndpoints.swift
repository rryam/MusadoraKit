//
//  AppleMusicEndPoint.swift
//  AppleMusicEndPoint
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation

public enum LibraryPath: String {
    case catalog
    case user
    
    var url: String {
        switch self {
            case .catalog: return "/catalog/"
            case .user: return "/me/"
        }
    }
}

public struct AppleMusicEndPoint {
    var library: LibraryPath? = nil
    var path: String
    var addStoreFront: Bool = true
    var queryItems: [URLQueryItem] = []
}

public extension AppleMusicEndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.music.apple.com/v1"
        components.queryItems = queryItems
        components.path = (library?.url ?? "")
        
        if addStoreFront, let storeFront = MusicKitManager.shared.storeFront {
            components.path += (storeFront + "/" + path)
        } else {
            components.path += ("/" + path)
        }
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

// MARK: - CATALOG
public extension AppleMusicEndPoint {
    static func genres() -> Self {
        AppleMusicEndPoint(library: .catalog, path: "genres")
    }
    
    static func search() -> Self {
        AppleMusicEndPoint(library: .catalog, path: "search")
    }
    
    static func hints(storeFront: String) -> Self {
        AppleMusicEndPoint(library: .catalog, path: "hints")
    }
}
