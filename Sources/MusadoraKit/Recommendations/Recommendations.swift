//
//  Recommendations.swift
//  
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

public struct Recommendations: Codable {
    let data: [Recommendation]
}

public struct Recommendation: Codable {
    let id: String
    let type: String
    let href: String
    let attributes: RecommendationAttributes
    let relationships: Relationships
}

public struct Relationships: Codable {
    let contents: MusicItemCollection<UserMusicItem>
}

public struct RecommendationAttributes: Codable {
    let nextUpdateDate: String
    let resourceTypes: [String]
    let kind: String
    let isGroupRecommendation: Bool
    let title: Title
}

enum UserMusicItem {
    case album(Album)
    case playlist(Playlist)
    case station(Station)
}

extension UserMusicItem: MusicItem {
    var id: MusicItemID {
        let id: MusicItemID

        switch self {
            case .album(let album): id = album.id
            case .playlist(let playlist): id = playlist.id
            case .station(let station): id = station.id
        }

        return id
    }
}

extension UserMusicItem: Decodable {
    enum CodingKeys: CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.decode(String.self, forKey: .type)
        switch type {
            case "albums", "library-albums":
                let album = try Album(from: decoder)
                self = .album(album)
            case "playlists", "library-playlists":
                let playlist = try Playlist(from: decoder)
                self = .playlist(playlist)
            case "stations":
                let station = try Station(from: decoder)
                self = .station(station)
            default:
                let decodingErrorContext = DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unexpected type \"\(type)\" encountered for UserMusicItem."
                )
                throw DecodingError.typeMismatch(UserMusicItem.self, decodingErrorContext)
        }
    }
}

extension UserMusicItem: Encodable {
    public func encode(to encoder: Encoder) throws {
    }
}

public struct Title: Codable {
    let stringForDisplay: String
    let contentIDS: [String]?

    enum CodingKeys: String, CodingKey {
        case stringForDisplay
        case contentIDS = "contentIds"
    }
}
