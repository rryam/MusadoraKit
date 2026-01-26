//
//  MusadoraKitError.swift
//  MusadoraKitError
//
//  Created by Rudrank Riyam on 09/04/22.
//

import Foundation

/// An enum representing all possible errors that can occur when using the MusadoraKit library.
public enum MusadoraKitError: Error, Equatable {
  /// The specified music item could not be found.
  case notFound(for: String)

  /// The specified music item is not in the user's library.
  case notInLibrary(item: String)

  /// One or more types must be specified for the operation.
  case typeMissing

  /// The recommendation limit was exceeded.
  case recommendationOverLimit(for: Int)

  /// The history limit was exceeded.
  case historyOverLimit(limit: Int, overLimit: Int)

  /// A monthly summary period could not be determined.
  case invalidSummaryPeriod

  /// One or more IDs must be specified for the operation.
  case idMissing

  /// The platform does not support this operation.
  case platformNotSupported

  /// The rating for the specified item could not be found.
  case ratingNotFound(for: String)

  /// Unable to count music items for the specified type.
  case unableToCountItems(for: String)

  /// The artwork URL could not be generated or is invalid.
  case invalidArtworkURL

  /// The artwork image data could not be decoded or is invalid.
  case invalidImageData

  /// The specified storefront could not be found.
  case storefrontNotFound(for: String)

  /// The equivalent music item type is not recognized or unsupported.
  case invalidEquivalentMusicItemType

  /// The library music item type is not recognized or unsupported.
  case invalidLibraryItemType

  /// The music recommendation item type is not supported for playback.
  case unsupportedRecommendationItemType

  /// The provided image is invalid or cannot be processed.
  case invalidImage

  /// The image resizing operation failed.
  case imageResizeFailed

  /// Failed to allocate memory for image processing.
  case imageMemoryAllocationFailed

  /// Failed to create a CGContext for image processing.
  case imageContextCreationFailed

  /// The position value is outside the valid range.
  case invalidPosition(limit: Int, provided: Int)
}

extension MusadoraKitError: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .notFound(id):
      return "The specified music item could not be found for \(id)."
    case let .notInLibrary(item):
      return "The \(item) is not in the user's library."
    case .typeMissing:
      return "One or more types or kinds must be specified for search suggestions."
    case let .recommendationOverLimit(limit):
      return "The recommendation limit was exceeded. Value must be an integer less than or equal to 30, but was \(limit)."
    case let .historyOverLimit(limit, overLimit):
      return "The history limit was exceeded. Value must be an integer less than or equal to \(limit), but was \(overLimit)."
    case .invalidSummaryPeriod:
      return "A monthly summary period could not be determined from the provided date context."
    case .idMissing:
      return "One or more IDs must be specified for the operation."
    case .platformNotSupported:
      return "This operation is only available on iOS."
    case let .ratingNotFound(id):
      return "No rating could be found for \(id)."
    case let .unableToCountItems(item):
      return "Unable to count the music items for \(item)."
    case .invalidArtworkURL:
      return "The artwork URL could not be generated or is invalid."
    case .invalidImageData:
      return "The artwork image data could not be decoded or is invalid."
    case let .storefrontNotFound(id):
      return "The specified storefront could not be found for ID \(id)."
    case .invalidEquivalentMusicItemType:
      return "The equivalent music item type is not recognized or unsupported."
    case .invalidLibraryItemType:
      return "The library music item type is not recognized or unsupported."
    case .unsupportedRecommendationItemType:
      return "The music recommendation item type is not supported for playback."
    case .invalidImage:
      return "The provided image is invalid or cannot be processed."
    case .imageResizeFailed:
      return "The image resizing operation failed."
    case .imageMemoryAllocationFailed:
      return "Failed to allocate memory for image processing."
    case .imageContextCreationFailed:
      return "Failed to create a CGContext for image processing."
    case let .invalidPosition(limit, provided):
      return "The position value \(provided) is outside the valid range (1-\(limit))."
    }
  }
}

extension MusadoraKitError: LocalizedError {
  /// A localized description of the error.
  public var errorDescription: String? {
    description
  }
}
