//
//  MCatalogSuggestionsResponse.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 09/04/22.
//

import Foundation
import MusicKit

/// An object that contains results for a catalog suggestions request.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
struct MCatalogSuggestionsResponse {
  /// A collection of search and display terms.
  var terms: [TermSuggestion] = []

  /// A collection of different top results.
  var topResults: [TopResultsSuggestion] = []
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
extension MCatalogSuggestionsResponse: Codable {
  private enum CodingKeys: String, CodingKey {
    case suggestions
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let suggestions = try container.decode([SuggestionKind].self, forKey: .suggestions)

    for suggestion in suggestions {
      switch suggestion {
      case let .terms(term):
        terms.append(term)

      case let .topResults(topResult):
        topResults.append(topResult)
      }
    }
  }

  func encode(to _: Encoder) throws {}
}
