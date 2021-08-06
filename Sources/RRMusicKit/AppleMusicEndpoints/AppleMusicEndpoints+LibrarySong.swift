//
//  AppleMusicEndpoints+LibrarySong.swift
//  AppleMusicEndpoints+LibrarySong
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation

// MARK: - REQUESTING A LIBRARY SONG
public extension AppleMusicEndPoint {
    static func getLibrarySong(id: String) -> Self {
        AppleMusicEndPoint(library: .user, "/library/songs/\(id)", addStoreFront: false)
    }
    
    static func getAllLibrarySongs(id: String) -> Self {
        AppleMusicEndPoint(library: .user, "/library/songs", addStoreFront: false)
    }
    
    static var userLibrary: Self {
        AppleMusicEndPoint(library: .user, "library", addStoreFront: false)
    }
}
