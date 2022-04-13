//
//  MusicRecommendationResponse.swift
//  MusicRecommendationResponse
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

/// An object that contains results for a recommendation request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct MusicRecommendationResponse {

    /// A collection of recommendation based on the `MusicRecommendationRequest`.
    public let items: Recommendations
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension MusicRecommendationResponse: Equatable {
    public static func == (lhs: MusicRecommendationResponse, rhs: MusicRecommendationResponse) -> Bool {
        lhs.items == rhs.items
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension MusicRecommendationResponse: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(items)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension MusicRecommendationResponse: Codable {}

extension MusicRecommendationResponse: CustomStringConvertible {
    public var description: String {
        "MusicRecommendationResponse(\(items.description))"
    }
}
