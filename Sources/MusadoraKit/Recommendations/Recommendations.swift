//
//  Recommendations.swift
//  Recommendations
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

public struct Title: Codable {
    let stringForDisplay: String
    let contentIDS: [String]?

    enum CodingKeys: String, CodingKey {
        case stringForDisplay
        case contentIDS = "contentIds"
    }
}
