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

/// Response structure for Apple Music API inFavorites queries.
private struct InFavoritesResponse: Decodable {
  let data: [InFavoritesResponseItem]
}

private struct InFavoritesResponseItem: Decodable {
  let attributes: InFavoritesAttributes?
  let relationships: InFavoritesRelationships?
}

private struct InFavoritesAttributes: Decodable {
  let inFavorites: Bool?
}

private struct InFavoritesRelationships: Decodable {
  let library: InFavoritesLibrary?
}

private struct InFavoritesLibrary: Decodable {
  struct Item: Decodable {}
  let data: [Item]
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
    let response = try JSONDecoder().decode(InFavoritesResponse.self, from: data)

    guard let item = response.data.first else {
      throw MusadoraKitError.notFound(for: "\(itemType.rawValue) in catalog")
    }

    guard let libraryData = item.relationships?.library?.data, !libraryData.isEmpty else {
      throw MusadoraKitError.notInLibrary(item: itemType.rawValue)
    }

    guard let inFavorites = item.attributes?.inFavorites else {
      throw MusadoraKitError.notFound(for: "inFavorites")
    }

    return inFavorites
  }

  /// Fetch inFavorites status for a music item from the Apple Music API.
  ///
  /// This helper method handles the common logic for fetching favorite status across all music item types.
  ///
  /// - Parameters:
  ///   - id: The catalog ID of the music item
  ///   - itemType: The type of music item
  /// - Returns: `true` if the item is in favorites, `false` otherwise
  /// - Throws: An error if the item is not in library or if the request fails
  static func fetchInFavorites(for id: MusicItemID, itemType: MusicItemType) async throws -> Bool {
    let storefront = try await MusicDataRequest.currentCountryCode
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(storefront)/\(itemType.rawValue)s/\(id.rawValue)"
    components.queryItems = [
      URLQueryItem(name: "relate", value: "library"),
      URLQueryItem(name: "extend", value: "inFavorites")
    ]

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()

    return try parse(from: response.data, itemType: itemType)
  }
}
