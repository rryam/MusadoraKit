//
//  AppleMusicEndpoints+CatalogSong.swift
//  AppleMusicEndpoints+CatalogSong
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation

public enum CatalogSongPath {
    case song
    case id(String)
    case relationship(String, RelationshipItem)
    
    var path: String {
        switch self {
            case .song:
                return "songs"
            case .id(let id):
                return "songs/\(id)"
            case .relationship(let id, let relationship):
                return "songs/\(id)/\(relationship.rawValue)"
        }
    }
}

// MARK: - REQUESTING A CATALOG SONG
public extension AppleMusicEndPoint {
    static func getCatalogSong(id: String) -> Self {
        AppleMusicEndPoint(library: .catalog, CatalogSongPath.id(id).path)
    }
    
    static func getMultipleCatalogSongsByID(ids: [String]) -> Self {
        let queryItem = URLQueryItem(name: "ids", value: ids.joined(separator: ","))
        return AppleMusicEndPoint(library: .catalog, CatalogSongPath.song.path, queryItems: [queryItem])
    }
    
    static func getMultipleCatalogSongsByISRC(isrc: [String]) -> Self {
        let queryItem = URLQueryItem(name: "filter[isrc]", value: isrc.joined(separator: ","))
        return AppleMusicEndPoint(library: .catalog, CatalogSongPath.song.path, queryItems: [queryItem])
    }
    
    static func getCatalogSongsByRelationship(id: String, relationship: RelationshipItem) -> Self {
        AppleMusicEndPoint(library: .catalog, CatalogSongPath.relationship(id, relationship).path)
    }
    
    static func getEquivalentCatalogSongsByID(equivalents: [String]) -> Self {
        let queryItem = URLQueryItem(name: "filter[equivalents]", value: equivalents.joined(separator: ","))
        return AppleMusicEndPoint(library: .catalog, CatalogSongPath.song.path, queryItems: [queryItem])
    }
}
