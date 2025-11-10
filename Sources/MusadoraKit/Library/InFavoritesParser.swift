//
//  InFavoritesParser.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/11/25.
//

import Foundation

/// The type of music item being parsed for inFavorites status.
internal enum MusicItemType: String {
  case song
  case album
  case artist
  case playlist
  case musicVideo = "music-video"
}

/// Internal parser for extracting inFavorites status from Apple Music API responses.
internal enum InFavoritesParser {
  /// Parse the inFavorites response from Apple Music API data.
  ///
  /// This function extracts the inFavorites boolean value from the API response,
  /// checking both that the item is in the library and that the inFavorites attribute exists.
  ///
  /// - Parameters:
  ///   - data: The raw Data from the API response
  ///   - itemType: The type of music item being parsed
  /// - Returns: The inFavorites boolean value
  /// - Throws: MusadoraKitError if parsing fails, item not found, not in library, or inFavorites not found
  static func parse(from data: Data, itemType: MusicItemType) throws -> Bool {
    // Parse to extract inFavorites from catalog attributes
    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
    guard let responseData = json?["data"] as? [[String: Any]],
          let first = responseData.first else {
      throw MusadoraKitError.notFound(for: "\(itemType.rawValue) in catalog")
    }

    let attributes = first["attributes"] as? [String: Any]

    // Check if item is in library
    if let relationships = first["relationships"] as? [String: Any],
       let library = relationships["library"] as? [String: Any],
       let libraryData = library["data"] as? [[String: Any]],
       libraryData.isEmpty {
      throw MusadoraKitError.notInLibrary(item: itemType.rawValue)
    }

    guard let inFavorites = attributes?["inFavorites"] as? Bool else {
      throw MusadoraKitError.notFound(for: "inFavorites")
    }

    return inFavorites
  }
}
