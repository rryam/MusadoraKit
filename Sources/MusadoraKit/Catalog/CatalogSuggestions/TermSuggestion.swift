//
//  TermSuggestion.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import MusicKit

/// A suggested search term from a search suggestion response.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
public struct TermSuggestion: Codable, Equatable, Hashable {
  /// The kind of suggestion.
  /// Value: terms
  public let kind: SuggestionsKind

  /// The term to use as a search input when using this suggestion.
  public let searchTerm: String

  /// A potentially censored term to display to the user to select from. Use the `searchTerm` value for the actual search.
  public let displayTerm: String
}
