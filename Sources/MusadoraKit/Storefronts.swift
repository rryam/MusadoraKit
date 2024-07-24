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

    let attributesContainer = try values.nestedContainer(keyedBy: AttributesCodingKeys.self, forKey: .attributes)
    explicitContentPolicy = try attributesContainer.decode(ExplicitContentPolicy.self, forKey: .explicitContentPolicy)
    name = try attributesContainer.decode(String.self, forKey: .name)
    supportedLanguageTags = try attributesContainer.decode([String].self, forKey: .supportedLanguageTags)
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

    var attributesContainer = container.nestedContainer(keyedBy: AttributesCodingKeys.self, forKey: .attributes)
    try attributesContainer.encode(explicitContentPolicy, forKey: .explicitContentPolicy)
    try attributesContainer.encode(name, forKey: .name)
    try attributesContainer.encode(supportedLanguageTags, forKey: .supportedLanguageTags)
    try attributesContainer.encode(defaultLanguageTag, forKey: .defaultLanguageTag)
  }
}

public extension MCatalog {

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
  static func storefront(id: String) async throws -> MStorefront {
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
  static func storefronts() async throws -> MStorefronts {
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
  private static func mapStorefrontIdFromCountryCode(_ countryCode: String) -> Int? {
    let storefrontData: [[String: Any]] = [
      ["name": "Algeria", "code": "dz", "storefrontId": 143563],
      ["name": "Angola", "code": "ao", "storefrontId": 143564],
      ["name": "Anguilla", "code": "ai", "storefrontId": 143538],
      ["name": "Antigua & Barbuda", "code": "ag", "storefrontId": 143540],
      ["name": "Argentina", "code": "ar", "storefrontId": 143505],
      ["name": "Armenia", "code": "am", "storefrontId": 143524],
      ["name": "Australia", "code": "au", "storefrontId": 143460],
      ["name": "Austria", "code": "at", "storefrontId": 143445],
      ["name": "Azerbaijan", "code": "az", "storefrontId": 143568],
      ["name": "Bahrain", "code": "bh", "storefrontId": 143559],
      ["name": "Bangladesh", "code": "bd", "storefrontId": 143490],
      ["name": "Barbados", "code": "bb", "storefrontId": 143541],
      ["name": "Belarus", "code": "by", "storefrontId": 143565],
      ["name": "Belgium", "code": "be", "storefrontId": 143446],
      ["name": "Belize", "code": "bz", "storefrontId": 143555],
      ["name": "Bermuda", "code": "bm", "storefrontId": 143542],
      ["name": "Bolivia", "code": "bo", "storefrontId": 143556],
      ["name": "Botswana", "code": "bw", "storefrontId": 143525],
      ["name": "Brazil", "code": "br", "storefrontId": 143503],
      ["name": "British Virgin Islands", "code": "vg", "storefrontId": 143543],
      ["name": "Brunei", "code": "bn", "storefrontId": 143560],
      ["name": "Bulgaria", "code": "bg", "storefrontId": 143526],
      ["name": "Canada", "code": "ca", "storefrontId": 143455],
      ["name": "Cayman Islands", "code": "ky", "storefrontId": 143544],
      ["name": "Chile", "code": "cl", "storefrontId": 143483],
      ["name": "China", "code": "cn", "storefrontId": 143465],
      ["name": "Colombia", "code": "co", "storefrontId": 143501],
      ["name": "Costa Rica", "code": "cr", "storefrontId": 143495],
      ["name": "Cote D'Ivoire", "code": "ci", "storefrontId": 143527],
      ["name": "Croatia", "code": "hr", "storefrontId": 143494],
      ["name": "Cyprus", "code": "cy", "storefrontId": 143557],
      ["name": "Czech Republic", "code": "cz", "storefrontId": 143489],
      ["name": "Denmark", "code": "dk", "storefrontId": 143458],
      ["name": "Dominica", "code": "dm", "storefrontId": 143545],
      ["name": "Dominican Rep.", "code": "do", "storefrontId": 143508],
      ["name": "Ecuador", "code": "ec", "storefrontId": 143509],
      ["name": "Egypt", "code": "eg", "storefrontId": 143516],
      ["name": "El Salvador", "code": "sv", "storefrontId": 143506],
      ["name": "Estonia", "code": "ee", "storefrontId": 143518],
      ["name": "Finland", "code": "fi", "storefrontId": 143447],
      ["name": "France", "code": "fr", "storefrontId": 143442],
      ["name": "Germany", "code": "de", "storefrontId": 143443],
      ["name": "Ghana", "code": "gh", "storefrontId": 143573],
      ["name": "Greece", "code": "gr", "storefrontId": 143448],
      ["name": "Grenada", "code": "gd", "storefrontId": 143546],
      ["name": "Guatemala", "code": "gt", "storefrontId": 143504],
      ["name": "Guyana", "code": "gy", "storefrontId": 143553],
      ["name": "Honduras", "code": "hn", "storefrontId": 143510],
      ["name": "Hong Kong", "code": "hk", "storefrontId": 143463],
      ["name": "Hungary", "code": "hu", "storefrontId": 143482],
      ["name": "Iceland", "code": "is", "storefrontId": 143558],
      ["name": "India", "code": "in", "storefrontId": 143467],
      ["name": "Indonesia", "code": "id", "storefrontId": 143476],
      ["name": "Ireland", "code": "ie", "storefrontId": 143449],
      ["name": "Israel", "code": "il", "storefrontId": 143491],
      ["name": "Italy", "code": "it", "storefrontId": 143450],
      ["name": "Jamaica", "code": "jm", "storefrontId": 143511],
      ["name": "Japan", "code": "jp", "storefrontId": 143462],
      ["name": "Jordan", "code": "jo", "storefrontId": 143528],
      ["name": "Kazakstan", "code": "kz", "storefrontId": 143517],
      ["name": "Kenya", "code": "ke", "storefrontId": 143529],
      ["name": "Korea, Republic Of", "code": "kr", "storefrontId": 143466],
      ["name": "Kuwait", "code": "kw", "storefrontId": 143493],
      ["name": "Latvia", "code": "lv", "storefrontId": 143519],
      ["name": "Lebanon", "code": "lb", "storefrontId": 143497],
      ["name": "Liechtenstein", "code": "li", "storefrontId": 143522],
      ["name": "Lithuania", "code": "lt", "storefrontId": 143520],
      ["name": "Luxembourg", "code": "lu", "storefrontId": 143451],
      ["name": "Macau", "code": "mo", "storefrontId": 143515],
      ["name": "Macedonia", "code": "mk", "storefrontId": 143530],
      ["name": "Madagascar", "code": "mg", "storefrontId": 143531],
      ["name": "Malaysia", "code": "my", "storefrontId": 143473],
      ["name": "Maldives", "code": "mv", "storefrontId": 143488],
      ["name": "Mali", "code": "ml", "storefrontId": 143532],
      ["name": "Malta", "code": "mt", "storefrontId": 143521],
      ["name": "Mauritius", "code": "mu", "storefrontId": 143533],
      ["name": "Mexico", "code": "mx", "storefrontId": 143468],
      ["name": "Moldova, Republic Of", "code": "md", "storefrontId": 143523],
      ["name": "Montserrat", "code": "ms", "storefrontId": 143547],
      ["name": "Nepal", "code": "np", "storefrontId": 143484],
      ["name": "Netherlands", "code": "nl", "storefrontId": 143452],
      ["name": "New Zealand", "code": "nz", "storefrontId": 143461],
      ["name": "Nicaragua", "code": "ni", "storefrontId": 143512],
      ["name": "Niger", "code": "ne", "storefrontId": 143534],
      ["name": "Nigeria", "code": "ng", "storefrontId": 143561],
      ["name": "Norway", "code": "no", "storefrontId": 143457],
      ["name": "Oman", "code": "om", "storefrontId": 143562],
      ["name": "Pakistan", "code": "pk", "storefrontId": 143477],
      ["name": "Panama", "code": "pa", "storefrontId": 143485],
      ["name": "Paraguay", "code": "py", "storefrontId": 143513],
      ["name": "Peru", "code": "pe", "storefrontId": 143507],
      ["name": "Philippines", "code": "ph", "storefrontId": 143474],
      ["name": "Poland", "code": "pl", "storefrontId": 143478],
      ["name": "Portugal", "code": "pt", "storefrontId": 143453],
      ["name": "Qatar", "code": "qa", "storefrontId": 143498],
      ["name": "Romania", "code": "ro", "storefrontId": 143487],
      ["name": "Russia", "code": "ru", "storefrontId": 143469],
      ["name": "Saudi Arabia", "code": "sa", "storefrontId": 143479],
      ["name": "Senegal", "code": "sn", "storefrontId": 143535],
      ["name": "Serbia", "code": "rs", "storefrontId": 143500],
      ["name": "Singapore", "code": "sg", "storefrontId": 143464],
      ["name": "Slovakia", "code": "sk", "storefrontId": 143496],
      ["name": "Slovenia", "code": "si", "storefrontId": 143499],
      ["name": "South Africa", "code": "za", "storefrontId": 143472],
      ["name": "Spain", "code": "es", "storefrontId": 143454],
      ["name": "Sri Lanka", "code": "lk", "storefrontId": 143486],
      ["name": "St. Kitts & Nevis", "code": "kn", "storefrontId": 143548],
      ["name": "St. Lucia", "code": "lc", "storefrontId": 143549],
      ["name": "St. Vincent & The Grenadines", "code": "vc", "storefrontId": 143550],
      ["name": "Suriname", "code": "sr", "storefrontId": 143554],
      ["name": "Sweden", "code": "se", "storefrontId": 143456],
      ["name": "Switzerland", "code": "ch", "storefrontId": 143459],
      ["name": "Taiwan", "code": "tw", "storefrontId": 143470],
      ["name": "Tanzania", "code": "tz", "storefrontId": 143572],
      ["name": "Thailand", "code": "th", "storefrontId": 143475],
      ["name": "The Bahamas", "code": "bs", "storefrontId": 143539],
      ["name": "Trinidad & Tobago", "code": "tt", "storefrontId": 143551],
      ["name": "Tunisia", "code": "tn", "storefrontId": 143536],
      ["name": "Turkey", "code": "tr", "storefrontId": 143480],
      ["name": "Turks & Caicos", "code": "tc", "storefrontId": 143552],
      ["name": "Uganda", "code": "ug", "storefrontId": 143537],
      ["name": "UK", "code": "gb", "storefrontId": 143444],
      ["name": "Ukraine", "code": "ua", "storefrontId": 143492],
      ["name": "United Arab Emirates", "code": "ae", "storefrontId": 143481],
      ["name": "Uruguay", "code": "uy", "storefrontId": 143514],
      ["name": "USA", "code": "us", "storefrontId": 143441],
      ["name": "Uzbekistan", "code": "uz", "storefrontId": 143566],
      ["name": "Venezuela", "code": "ve", "storefrontId": 143502],
      ["name": "Vietnam", "code": "vn", "storefrontId": 143471],
      ["name": "Yemen", "code": "ye", "storefrontId": 143571]
    ]

    return storefrontData.first { $0["code"] as? String == countryCode }?["storefrontId"] as? Int
  }
}
