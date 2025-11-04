//
//  Suggestions.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation

/// The response to a request for search suggestions.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public struct Suggestions: Codable {
  /// The results included in the response to a request for search suggestions.
  let results: MusicCatalogSuggestionsResponse
}
