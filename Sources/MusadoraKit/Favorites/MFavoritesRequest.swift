//
//  MFavoritesRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 09/02/25.
//

import Foundation

/// A request that your app uses to add resources to favorites.
struct MFavoritesRequest {
  private var itemIDs: [MusicItemID]

  /// Creates a request to add resources to favorites.
  ///
  /// - Parameter itemIDs: The IDs of the items to add to favorites.
  ///   Supports heterogeneous types (songs, albums, playlists, artists, etc.)
  init(itemIDs: [MusicItemID]) {
    self.itemIDs = itemIDs
  }

  /// Creates a request to add a single resource to favorites.
  ///
  /// - Parameter itemID: The ID of the item to add to favorites.
  init(itemID: MusicItemID) {
    self.itemIDs = [itemID]
  }

  /// Executes the request to add items to favorites and returns
  /// a boolean value indicating the success of the operation.
  func response() async throws -> Bool {
    let url = try favoritesEndpointURL
    let request = MDataPostRequest(url: url)
    let response = try await request.response()
    return response.urlResponse.statusCode == 202
  }
}

extension MFavoritesRequest {
  internal var favoritesEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []
      components.path = "me/favorites"

      // Join all item IDs with commas as per official API spec
      let idsString = itemIDs.map { $0.rawValue }.joined(separator: ",")
      queryItems.append(URLQueryItem(name: "ids", value: idsString))

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      return url
    }
  }
}
