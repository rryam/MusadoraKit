//
//  MusicRecommendationResponse.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

/// An object that contains results for a recommendation request.
///
/// This structure wraps the recommendations returned by the Apple Music API,
/// providing access to personalized music recommendations for the user.
///
/// Example usage:
/// ```swift
/// let request = MRecommendationRequest()
/// let response = try await request.response()
///
/// // Access recommended items
/// for recommendation in response.items {
///     print(recommendation.title)
///     print(recommendation.albums)
///     print(recommendation.playlists)
/// }
/// ```
public struct MRecommendationResponse {
  /// A collection of recommendations based on the `MusicRecommendationRequest`.
  /// Each recommendation may contain different types of content like albums,
  /// playlists, or stations.
  public let items: MRecommendations
}

extension MRecommendationResponse: Equatable, Hashable, Codable {}

extension MRecommendationResponse: CustomStringConvertible {
  public var description: String {
    "MusicRecommendationResponse(\(items.description))"
  }
}
