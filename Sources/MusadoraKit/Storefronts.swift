//
//  Storefronts.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 11/03/23.
//

import Foundation

/// An array of Music Storefronts.
public typealias MStorefronts = [MStorefront]

struct StorefrontsData: Codable {
  let data: [MStorefront]
}

/// A Music Storefront.
public struct MStorefront: Codable {

  /// The identifier of the storefront.
  public let id: String

  /// The type of the storefront.
  public let type: `Type`

  /// The explicit content policy for the storefront.
  public let explicitContentPolicy: ExplicitContentPolicy

  /// The name of the storefront.
  public let name: String

  /// The language tags supported by the storefront.
  public let supportedLanguageTags: [String]

  /// The default language tag for the storefront.
  public let defaultLanguageTag: String

  enum CodingKeys: String, CodingKey {
    case id, type, attributes
  }

  enum AttributesCodingKeys: String, CodingKey {
    case explicitContentPolicy, name
    case supportedLanguageTags, defaultLanguageTag
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(String.self, forKey: .id)
    type = try values.decode(`Type`.self, forKey: .type)

    let attributesContainer = try values.nestedContainer(keyedBy: AttributesCodingKeys.self, forKey: .attributes)
    explicitContentPolicy = try attributesContainer.decode(ExplicitContentPolicy.self, forKey: .explicitContentPolicy)
    name = try attributesContainer.decode(String.self, forKey: .name)
    supportedLanguageTags = try attributesContainer.decode([String].self, forKey: .supportedLanguageTags)
    defaultLanguageTag = try attributesContainer.decode(String.self, forKey: .defaultLanguageTag)
  }

  public enum ExplicitContentPolicy: String, Codable {
    case allowed
    case optIn = "opt-in"
    case prohibited
  }

  public enum `Type`: String, Codable {
    case storefronts
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(type, forKey: .type)

    var attributesContainer = container.nestedContainer(keyedBy: AttributesCodingKeys.self, forKey: .attributes)
    try attributesContainer.encode(explicitContentPolicy, forKey: .explicitContentPolicy)
    try attributesContainer.encode(name, forKey: .name)
    try attributesContainer.encode(supportedLanguageTags, forKey: .supportedLanguageTags)
    try attributesContainer.encode(defaultLanguageTag, forKey: .defaultLanguageTag)
  }
}

public extension MCatalog {
  
  /// Fetch a specific storefront of Apple Music by its unique identifier.
  ///
  /// - Parameter id: The unique identifier for the storefront you want to fetch.
  /// - Returns: `Storefront` object containing the details of the requested storefront.
  static func storefront(id: String) async throws -> MStorefront {
    let url = try storefrontsURL(id: id)

    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let storefront = try JSONDecoder().decode(StorefrontsData.self, from: response.data).data.first

    guard let storefront else {
      throw NSError(domain: "Storefront not found for ID \(id).", code: 0)
    }

    return storefront
  }

  /// Fetch all storefronts of Apple Music.
  ///
  /// - Returns: `Storefronts` as array of storefronts.
  static func storefronts() async throws -> MStorefronts {
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

  internal static func storefrontsURL(id: String) throws -> URL {
    var urlComponents = AppleMusicURLComponents()
    urlComponents.path = "storefronts/\(id)"

    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
