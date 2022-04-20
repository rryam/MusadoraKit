//
//  Recommendation.swift
//  Recommendation
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

/// A collection of recommendations.
public typealias Recommendations = MusicItemCollection<Recommendation>

/// An object that represents recommended resources for a user calculated using their selected preferences.
public struct Recommendation: Codable, MusicItem {

    /// The identifier for the recommendation.
    public let id: MusicItemID

    /// The localized title for the recommendation.
    public let title: String

    /// The contents associated with the content recommendation type.
    /// It is a collection of `UserMusicItem` that are a mixture of albums, playlists and stations.
    public let contents: UserMusicItems

    /// The next date in UTC format for updating the recommendation.
    public let nextUpdate: Date

    /// A collection of recommended albums.
    public var albums: Albums {
        MusicItemCollection(contents.compactMap { item in
            if case let .album(album) = item {
                return album
            } else {
                return nil
            }
        })
    }

    /// A collection of recommended playlists.
    public var playlists: Playlists {
        MusicItemCollection(contents.compactMap { item in
            if case let .playlist(playlist) = item {
                return playlist
            } else {
                return nil
            }
        })
    }

    /// A collection of recommended stations.
    public var stations: Stations {
        MusicItemCollection(contents.compactMap { item in
            if case let .station(station) = item {
                return station
            } else {
                return nil
            }
        })
    }
}

extension Recommendation {
    enum CodingKeys: String, CodingKey {
        case id, attributes, relationships
    }

    enum RelationshipKey: String, CodingKey {
        case contents
    }

    enum AttributesKey: String, CodingKey {
        case title
        case nextUpdate = "nextUpdateDate"
    }

    enum TitleKey: String, CodingKey {
        case stringForDisplay
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(MusicItemID.self, forKey: .id)

        let relationshipContainer = try container.nestedContainer(keyedBy: RelationshipKey.self, forKey: .relationships)
        contents = try relationshipContainer.decode(UserMusicItems.self, forKey: .contents)

        let attributesContainer = try container.nestedContainer(keyedBy: AttributesKey.self, forKey: .attributes)
        nextUpdate = try attributesContainer.decode(Date.self, forKey: .nextUpdate)

        let titleContainer = try attributesContainer.nestedContainer(keyedBy: TitleKey.self, forKey: .title)
        title = try titleContainer.decode(String.self, forKey: .stringForDisplay)
    }
}


extension Recommendation {
    public func encode(to encoder: Encoder) throws {

    }
}


extension Recommendation: Equatable, Hashable {}
