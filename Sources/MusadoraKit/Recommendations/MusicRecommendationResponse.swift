//
//  MusicRecommendationResponse.swift
//  MusicRecommendationResponse
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

/// An object that contains results for a recommendation request.
public struct MusicRecommendationResponse {
  /// A collection of recommendation based on the `MusicRecommendationRequest`.
  public let items: Recommendations
}

extension MusicRecommendationResponse: Equatable, Hashable, Codable {}

extension MusicRecommendationResponse: CustomStringConvertible {
  public var description: String {
    "MusicRecommendationResponse(\(items.description))"
  }
}
