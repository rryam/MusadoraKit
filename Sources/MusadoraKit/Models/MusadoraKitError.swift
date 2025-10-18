//
//  MusadoraKitError.swift
//  MusadoraKitError
//
//  Created by Rudrank Riyam on 09/04/22.
//

import Foundation

/// An enum representing the possible errors that can occur when fetching ratings for a music item.
public enum RatingsError: Error, Equatable {
  case typeMissing
  case idMissing
}

extension RatingsError: CustomStringConvertible {
  public var description: String {
    switch self {
    case .idMissing:
      return "One or more ID must be specified to fetch the ratings for it."
    case .typeMissing:
      return "The music item type must be specified to fetch its ratings."
    }
  }
}

/// An enum representing the possible errors that can occur when playing a piece of media.
public enum MediaPlayError: Error, Equatable {
  case notFound(for: String)
  case platformNotSupported
}

extension MediaPlayError: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .notFound(item):
      return "Not able to count the music items for \(item)."
    case .platformNotSupported:
      return "This is only available on iOS."
    }
  }
}

/// An enum representing the possible errors that can occur when using the MusadoraKit library.
public enum MusadoraKitError: Error, Equatable {
  case notFound(for: String)
  case typeMissing
  case recommendationOverLimit(for: Int)
  case historyOverLimit(limit: Int, overLimit: Int)
  case invalidSummaryPeriod
}

extension MusadoraKitError: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .notFound(id):
      return "The specified music item could not be found for \(id)."
    case .typeMissing:
      return "One or more types must be specified for fetching top results in search suggestions."
    case let .recommendationOverLimit(limit):
      return "Value must be an integer less than or equal to 30, but was: \(limit)."
    case let .historyOverLimit(limit, overLimit):
      return "Value must be an integer less than or equal to \(limit), but was: \(overLimit)."
    case .invalidSummaryPeriod:
      return "A monthly summary period could not be determined from the provided date context."
    }
  }
}

extension MusadoraKitError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case let .notFound(id):
      return NSLocalizedString("The specified music item could not be found for \(id).",
                               comment: "Resource Not Found")
    case .typeMissing:
      return NSLocalizedString("One or more types must be specified for fetching top results in search suggestions.",
                               comment: "Missing Parameter")
    case let .recommendationOverLimit(limit):
      return NSLocalizedString("Value must be an integer less than or equal to 30, but was: \(limit).",
                               comment: "Invalid Parameter Value")
    case let .historyOverLimit(limit, overLimit):
      return NSLocalizedString("Value must be an integer less than or equal to \(limit), but was: \(overLimit).",
                               comment: "Invalid Parameter Value")
    case .invalidSummaryPeriod:
      return NSLocalizedString("A monthly summary period could not be determined from the provided date context.",
                               comment: "Invalid Summary Period")
    }
  }
}
