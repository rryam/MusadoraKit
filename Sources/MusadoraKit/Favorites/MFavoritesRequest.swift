//
//  MFavoritesRequest.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation
import MusicKit

struct MFavoritesRequest {
  private var artistID: MusicItemID
  private var type: MFavoriteRequestType

  init(artist: Artist, type: MFavoriteRequestType) {
    self.artistID = artist.id
    self.type = type
  }

  func response() async throws -> Bool {
    switch type {
      case .favorite:
        let url = try favortiesEndpointURL
        let request = MDataPostRequest(url: url)
        let response = try await request.response()
        return response.urlResponse.statusCode == 202
      case .removeFavorite:
        let url = try favortiesEndpointURL
        let request = MDataDeleteRequest(url: url)
        let response = try await request.response()
        return response.urlResponse.statusCode == 204
    }
  }
}

extension MFavoritesRequest {
  internal var favortiesEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []
      components.path = "me/favorites"

      queryItems.append(URLQueryItem(name: "ids[artists]", value: artistID.rawValue))

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      return url
    }
  }
}
