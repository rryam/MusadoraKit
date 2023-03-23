//
//  Storefronts.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 11/03/23.
//


import Foundation

public typealias Storefronts = [StorefrontsData.Storefront]

public struct StorefrontsData: Codable {
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

public extension MCatalog {
  
  /// Fetch a specific storefront of Apple Music by its unique identifier.
  ///
  /// - Parameter id: The unique identifier for the storefront you want to fetch.
  /// - Returns: `Storefront` object containing the details of the requested storefront.
  static func storefront(id: String) async throws -> StorefrontsData.Storefront {
    let url = try storefrontsURL(id: id)

    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let storefront = try JSONDecoder().decode(StorefrontsData.self, from: response.data).data.first

    guard let storefront else {
      throw NSError(domain: "Storefront not found for ID \(id).", code: 0)
    }

    return storefront
  }

  internal static func storefrontsURL(id: String) throws -> URL {
    var urlComponents = AppleMusicURLComponents()
    urlComponents.path = "storefronts/\(id)"

    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }

    return url
  }

  /// Fetch all storefronts of Apple Music.
  ///
  /// - Returns: `Storefronts` as array of storefronts.
  static func storefronts() async throws -> Storefronts {
    let url = try storefrontsURL()
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let storefronts = try JSONDecoder().decode(StorefrontsData.self, from: response.data)
    return storefronts.data
  }

  internal static func storefrontsURL() throws -> URL {
    var urlComponents = AppleMusicURLComponents()
    urlComponents.path = "storefronts"

    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
