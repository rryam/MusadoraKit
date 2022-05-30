//
//  File.swift
//
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation
import MusicKit

public struct Storefronts: Codable {
  let data: [Storefront]

  public struct Storefront: Codable {
    public let id: String
    public let type: `Type`
    public let attributes: Attributes

    public struct Attributes: Codable {
      public let explicitContentPolicy: ExplicitContentPolicy
      public let name: String
      public let supportedLanguageTags: [String]
      public let defaultLanguageTag: String
    }

    public enum ExplicitContentPolicy: String, Codable {
      case allowed
      case optIn = "opt-in"
      case prohibited
    }

    public enum `Type`: String, Codable {
      case storefronts
    }
  }
}

public extension MusadoraLabsKit {
  static func storefronts() async throws -> [Storefronts.Storefront] {
    let url = URL(string: "https://api.music.apple.com/v1/storefronts")!
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let storefronts = try JSONDecoder().decode(Storefronts.self, from: response.data)
    return storefronts.data
  }
}
