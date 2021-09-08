//
//  LibraryPath.swift
//  LibraryPath
//
//  Created by Rudrank Riyam on 14/08/21.
//

import Foundation

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
