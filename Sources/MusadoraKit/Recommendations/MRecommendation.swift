//
//  MRecommendation.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//

/// Structure containing the methods related to the Apple Music recommendations.
///
/// `MRecommendation` provides access to Apple Music's recommendation system,
/// allowing you to fetch personalized music recommendations for users.
///
/// Example usage:
/// ```swift
/// // Fetch default recommendations
/// let recommendations = try await MRecommendation.default()
///
/// // Access recommended content
/// print(recommendations.first?.albums)
/// print(recommendations.first?.playlists)
/// ```
public struct MRecommendation {
}
