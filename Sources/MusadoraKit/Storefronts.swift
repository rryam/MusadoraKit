//
//  Storefronts.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 11/03/23.
//

import Foundation

/// `MStorefronts` is a type alias for an array of `MStorefront` instances.
///
/// This represents a collection of Apple Music storefronts, which can be used when making requests to the
/// Apple Music API that require a storefront.
public typealias MStorefronts = [MStorefront]

/// `StorefrontsData` is a struct that decodes the data from a JSON object into an array of `MStorefront` instances.
///
/// This structure corresponds to the response you would receive when fetching a list of Apple Music storefronts.
struct StorefrontsData: Codable {

  /// An array of `MStorefront` instances, representing the storefronts returned in the API response.
  let data: [MStorefront]
}

/// Represents a storefront in the Apple Music service.
///
/// A storefront corresponds to a geographical region and contains content specific to that region.
/// It includes several attributes like the storefront name, language settings, and explicit content policy.
///
/// Example usage:
/// ```swift
/// // Fetch storefront details by identifier
/// let usStorefront = try await MCatalog.storefront(id: "us")
/// print("US storefront: \(usStorefront.name)")
///
/// // Determine the active storefront from MusicKit, then fetch details
/// let storefront = try await Storefront.current
/// let storefrontDetails = try await MCatalog.storefront(id: storefront.id)
/// print("Current storefront: \(storefrontDetails.id)")
///
/// // Fetch all available storefronts
/// let allStorefronts = try await MCatalog.storefronts()
/// for storefront in allStorefronts {
///     print("\(storefront.name) (\(storefront.id))")
/// }
/// ```
public struct MStorefront: Codable {

  /// The unique identifier for the storefront (e.g., "us", "gb", "jp").
  public let id: String

  /// The display name of the storefront in its default language.
  public let name: String

  /// The type of the storefront.
  public let type: `Type`

  /// The explicit content policy for the storefront.
  public let explicitContentPolicy: ExplicitContentPolicy

  /// The Apple iTunes storefront ID.
  ///
  /// This property represents the unique identifier for the storefront in Apple's iTunes system.
  /// It is populated during initialisation by mapping the country code (stored in `id`)
  /// to its corresponding iTunes storefront ID. The property is optional because not all country codes
  /// may have a matching iTunes storefront ID in the mapping data.
  ///
  /// - Note: This ID is particularly useful for making API calls to iTunes or Apple Music services
  ///         that require a specific storefront identifier.
  public let storefrontId: Int?

  /// The language tags supported by the storefront.
  public let supportedLanguageTags: [String]

  /// The default language tag for the storefront.
  public let defaultLanguageTag: String

  enum CodingKeys: String, CodingKey {
    case id
    case type
    case attributes
  }

  enum AttributesCodingKeys: String, CodingKey {
    case explicitContentPolicy
    case name
    case supportedLanguageTags
    case defaultLanguageTag
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(String.self, forKey: .id)
    type = try values.decode(`Type`.self, forKey: .type)

    let attributesContainer = try values.nestedContainer(
      keyedBy: AttributesCodingKeys.self, forKey: .attributes)
    explicitContentPolicy = try attributesContainer.decode(
      ExplicitContentPolicy.self, forKey: .explicitContentPolicy)
    name = try attributesContainer.decode(String.self, forKey: .name)
    supportedLanguageTags = try attributesContainer.decode(
      [String].self, forKey: .supportedLanguageTags)
    defaultLanguageTag = try attributesContainer.decode(String.self, forKey: .defaultLanguageTag)
    storefrontId = MStorefront.mapStorefrontIdFromCountryCode(id)
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

    var attributesContainer = container.nestedContainer(
      keyedBy: AttributesCodingKeys.self, forKey: .attributes)
    try attributesContainer.encode(explicitContentPolicy, forKey: .explicitContentPolicy)
    try attributesContainer.encode(name, forKey: .name)
    try attributesContainer.encode(supportedLanguageTags, forKey: .supportedLanguageTags)
    try attributesContainer.encode(defaultLanguageTag, forKey: .defaultLanguageTag)
  }
}

extension MCatalog {

  /// Fetches a specific storefront of Apple Music by its unique identifier.
  ///
  /// A storefront represents the Apple Music service in a particular geographic region and
  /// contains regional-specific content and configuration settings. It is identified by a region code.
  ///
  /// Example usage:
  ///
  /// ```swift
  /// do {
  ///     let storefront = try await MCatalog.storefront(id: "us")
  ///     print(storefront)
  /// } catch {
  ///     print("Failed to fetch storefront: \(error)")
  /// }
  /// ```
  ///
  /// In the above example, "us" is the identifier for the United States storefront.
  ///
  /// - Parameter id: The unique identifier for the storefront you want to fetch. This is usually a country code.
  /// - Returns: A `MStorefront` object containing the details of the requested storefront.
  /// - Throws: An error if the storefront cannot be found, or if there was a problem decoding the response.
  public static func storefront(id: String) async throws -> MStorefront {
    let url = try storefrontsURL(id: id)

    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let storefront = try JSONDecoder().decode(StorefrontsData.self, from: response.data).data.first

    guard let storefront = storefront else {
      throw NSError(domain: "Storefront not found for ID \(id).", code: 0)
    }

    return storefront
  }

  /// Fetches all the available storefronts of Apple Music.
  ///
  /// A storefront represents the Apple Music service in a particular geographic region and
  /// contains regional-specific content and configuration settings.
  ///
  /// Example usage:
  ///
  /// ```swift
  /// do {
  ///     let storefronts = try await MCatalog.storefronts()
  ///     print(storefronts)
  /// } catch {
  ///     print("Failed to fetch storefronts: \(error)")
  /// }
  /// ```
  ///
  /// - Returns: An array of `MStorefront` objects, each representing a different storefront.
  /// - Throws: An error if there was a problem with the network request, or if the response couldn't be decoded.
  public static func storefronts() async throws -> MStorefronts {
    let url = try storefrontsURL()
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let storefronts = try JSONDecoder().decode(StorefrontsData.self, from: response.data)
    return storefronts.data
  }

  /// Generates the URL to fetch all the available storefronts of Apple Music.
  ///
  /// - Returns: The URL to fetch all the available storefronts of Apple Music.
  internal static func storefrontsURL() throws -> URL {
    var urlComponents = AppleMusicURLComponents()
    urlComponents.path = "storefronts"

    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }

    return url
  }

  /// Returns the URL for fetching the specified storefront.
  ///
  /// - Parameter id: The identifier for the storefront.
  ///
  /// - Returns: The URL for fetching the specified storefront.
  internal static func storefrontsURL(id: String) throws -> URL {
    var urlComponents = AppleMusicURLComponents()
    urlComponents.path = "storefronts/\(id)"

    guard let url = urlComponents.url else {
      throw URLError(.badURL)
    }

    return url
  }
}

extension MStorefront {
  internal struct StorefrontLookupEntry: Decodable {
    let code: String
    let storefrontId: Int
  }

  private static let storefrontIDLookup: [String: Int] = {
    guard let url = Bundle.module.url(forResource: "storefront-ids", withExtension: "json") else {
      assertionFailure("Missing storefront-ids.json resource.")
      return [:]
    }

    do {
      let data = try Data(contentsOf: url)
      return loadStorefrontLookup(from: data)
    } catch {
      assertionFailure("Failed to load storefront mapping data: \(error)")
      return [:]
    }
  }()

  internal static func decodeStorefrontLookup(from data: Data) throws -> [String: Int] {
    let entries = try JSONDecoder().decode([StorefrontLookupEntry].self, from: data)
    return Dictionary(uniqueKeysWithValues: entries.map { ($0.code.lowercased(), $0.storefrontId) })
  }

  internal static func loadStorefrontLookup(from data: Data) -> [String: Int] {
    do {
      return try decodeStorefrontLookup(from: data)
    } catch {
      #if DEBUG
      debugPrint("Failed to decode storefront mapping: \(error)")
      #endif
      return [:]
    }
  }

  internal static func storefrontID(forCountryCode countryCode: String) -> Int? {
    storefrontIDLookup[countryCode.lowercased()]
  }

  private static func mapStorefrontIdFromCountryCode(_ countryCode: String) -> Int? {
    storefrontID(forCountryCode: countryCode)
  }
}
