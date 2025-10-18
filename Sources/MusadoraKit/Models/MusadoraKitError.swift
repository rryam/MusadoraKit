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
      let fmt = NSLocalizedString("mk_error_not_found", comment: "Resource Not Found")
      return String(format: fmt, id)
    case .typeMissing:
      return NSLocalizedString("mk_error_type_missing_suggestions", comment: "Missing Parameter")
    case let .recommendationOverLimit(limit):
      let fmt = NSLocalizedString("mk_error_recommendation_over_limit", comment: "Invalid Parameter Value")
      return String(format: fmt, limit)
    case let .historyOverLimit(limit, overLimit):
      let fmt = NSLocalizedString("mk_error_history_over_limit", comment: "Invalid Parameter Value")
      return String(format: fmt, limit, overLimit)
    case .invalidSummaryPeriod:
      return NSLocalizedString("mk_error_invalid_summary_period", comment: "Invalid Summary Period")
    }
  }
}
