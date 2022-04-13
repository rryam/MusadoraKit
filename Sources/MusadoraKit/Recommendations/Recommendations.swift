//
//  Recommendation.swift
//  Recommendation
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

/// A collection of recommendations.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public typealias Recommendations = MusicItemCollection<Recommendation>

/// An object that represents recommended resources for a user calculated using their selected preferences.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct Recommendation: Codable, MusicItem {

    /// The identifier for the recommendation.
    public let id: MusicItemID

    /// The localized title for the recommendation.
    public let title: String

    /// The contents associated with the content recommendation type.
    /// It is a collection of `UserMusicItem` that are a mixture of albums, playlists and stations.
    public let contents: MusicItemCollection<UserMusicItem>

    private struct Relationships: Codable {
        let contents: MusicItemCollection<UserMusicItem>
    }

    private struct RecommendationAttributes: Codable {
        let title: Title

        struct Title: Codable {
            let stringForDisplay: String
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title = "attributes"
        case contents = "relationships"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(MusicItemID.self, forKey: .id)
        title = try container.decode(RecommendationAttributes.self, forKey: .title).title.stringForDisplay
        contents = try container.decode(Relationships.self, forKey: .contents).contents
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Recommendation: Equatable, Hashable {}
