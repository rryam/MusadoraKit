//
//  SuggestionKind.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

/// The suggestion kinds to include in the results.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
public enum SuggestionKind: Codable {
  case terms(TermSuggestion)
  case topResults(TopResultsSuggestion)

  private enum CodingKeys: String, CodingKey {
    case kind
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let kind = try container.decode(SuggestionsKind.self, forKey: .kind)

    switch kind {
    case .terms:
      let termSuggestion = try TermSuggestion(from: decoder)
      self = .terms(termSuggestion)
    case .topResults:
      let topResultsSuggestion = try TopResultsSuggestion(from: decoder)
      self = .topResults(topResultsSuggestion)
    }
  }

  public func encode(to _: Encoder) throws {}
}
