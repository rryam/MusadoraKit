//
//  HundredBestAlbum.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 19/05/24.
//

import Foundation

/// A structure representing an album from Apple Music's 100 Best Albums list.
///
/// This structure provides detailed information about albums featured in Apple Music's
/// curated list of 100 best albums, including rich content like descriptions and artwork.
///
/// Example usage:
/// ```swift
/// let album = try await MCatalog.hundredBestAlbum(id: "1234567890")
/// print("Position: \(album.position)")
/// print("Name: \(album.name)")
/// print("Artist: \(album.artistName)")
///
/// // Access album artwork
/// let artwork = album.artwork
/// print("Artwork URL: \(artwork.url(width: 300, height: 300))")
/// ```
public struct HundredBestAlbum: Identifiable, MusicItem {
  /// The unique identifier for the album.
  public let id: MusicItemID

  /// The name of the album.
  public let name: String

  /// The position of the album in the 100 Best Albums list (1-100).
  public let position: String

  /// The formatted title of the album.
  public let title: String

  /// The artwork associated with the album.
  public let artwork: Artwork

  /// The URL to the album's page on Apple Music.
  public let url: URL

  /// The name of the artist who created the album.
  public let artistName: String

  /// An array of sections containing rich content about the album.
  public let sections: [Section]

  /// The coding keys used for encoding and decoding the album data.
  enum CodingKeys: String, CodingKey {
    case adamid
    case name
    case position
    case title
    case artwork
    case url
    case artistName
    case sections
  }

  /// A structure representing a content section within an album's description.
  ///
  /// Each section can contain different types of content, such as text descriptions,
  /// pull quotes with attributions, or images with alternative text.
  ///
  /// Example of accessing section content:
  ///
  /// ```swift
  /// for section in album.sections {
  ///     switch section.sectionName {
  ///     case "pullQuote":
  ///         print("Quote: \(section.text ?? "")")
  ///         print("By: \(section.attribution ?? "")")
  ///     case "blurb":
  ///         print("Description: \(section.text ?? "")")
  ///     default:
  ///         break
  ///     }
  /// }
  /// ```
  public struct Section: Codable, Sendable {
    /// The type of content section (e.g., "blurb", "pullQuote").
    public let sectionName: String

    /// The main text content of the section.
    public let text: String?

    /// A key identifier for the section content.
    public let key: String?

    /// URL to any artwork associated with this section.
    public let artwork: URL?

    /// Alternative text for the section content.
    public let altText: String?

    /// Key for the image's alternative text.
    public let imageAltKey: String?

    /// Alternative text for images.
    public let imageAlt: String?

    /// Attribution for quotes or other content.
    public let attribution: String?

    /// Key for the pull quote attribution.
    public let pullQuoteAttrKey: String?

    /// Attribution text for pull quotes.
    public let pullQuoteAttr: String?
  }
}

/// Conformance to `Codable` protocol for JSON encoding and decoding.
extension HundredBestAlbum: Codable {
  /// Encodes the album into a JSON format.
  ///
  /// - Parameter encoder: The encoder to write data to.
  /// - Throws: An error if encoding fails.
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id.rawValue, forKey: .adamid)
    try container.encode(name, forKey: .name)
    try container.encode(position, forKey: .position)
    try container.encode(title, forKey: .title)
    try container.encode(artwork, forKey: .artwork)
    try container.encode(url, forKey: .url)
    try container.encode(artistName, forKey: .artistName)
    try container.encode(sections, forKey: .sections)
  }

  /// Creates a new album instance by decoding from JSON.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if decoding fails.
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let adamid = try container.decode(String.self, forKey: .adamid)
    id = MusicItemID(rawValue: adamid)
    name = try container.decode(String.self, forKey: .name)
    position = try container.decode(String.self, forKey: .position)
    title = try container.decode(String.self, forKey: .title)
    artwork = try container.decode(Artwork.self, forKey: .artwork)
    url = try container.decode(URL.self, forKey: .url)
    artistName = try container.decode(String.self, forKey: .artistName)
    sections = try container.decode([Section].self, forKey: .sections)
  }
}
