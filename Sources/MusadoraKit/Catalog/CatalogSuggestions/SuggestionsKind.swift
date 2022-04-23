//
//  SuggestionsKind.swift
//  SuggestionsKind
//
//  Created by Rudrank Riyam on 23/04/22.
//

import MusicKit

/// The suggestion kinds to include in the results.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
public enum SuggestionsKind: String, Codable {
    case terms
    case topResults
}
