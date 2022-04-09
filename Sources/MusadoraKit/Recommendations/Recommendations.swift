//
//  Recommendations.swift
//  Recommendations
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct Recommendations: Codable {
    let data: [Recommendation]

    public struct Recommendation: Codable {
        let id: String
        let type: String
        let href: String
        let attributes: RecommendationAttributes
        let relationships: Relationships

        public struct Relationships: Codable {
            let contents: MusicItemCollection<UserMusicItem>
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct RecommendationAttributes: Codable {
    let nextUpdateDate: String
    let resourceTypes: [String]
    let kind: String
    let isGroupRecommendation: Bool
    let title: Title

    public struct Title: Codable {
        let stringForDisplay: String
        let contentIDS: [String]?

        enum CodingKeys: String, CodingKey {
            case stringForDisplay
            case contentIDS = "contentIds"
        }
    }
}
