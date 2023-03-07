//
//  MusicRecommendationResponse.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

/// An object that contains results for a recommendation request.
public struct MRecommendationResponse {
  /// A collection of recommendation based on the `MusicRecommendationRequest`.
  public let items: MRecommendations
}

extension MRecommendationResponse: Equatable, Hashable, Codable {}

extension MRecommendationResponse: CustomStringConvertible {
  public var description: String {
    "MusicRecommendationResponse(\(items.description))"
  }
}
