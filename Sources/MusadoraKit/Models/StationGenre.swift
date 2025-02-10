//
//  StationGenre.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 12/03/23.
//

/// A structure representing a station genre in the Apple Music API.
///
/// Station genres are used to categorize and organize radio stations in Apple Music.
/// Each genre has a unique identifier, type, and display name.
///
/// Example usage:
/// ```swift
/// let genre = try await MCatalog.stationGenre(id: "42")
/// print(genre.name)  // e.g., "Hip-Hop"
/// print(genre.id)    // The unique identifier
/// ```
public struct StationGenre: Sendable {

  /// The unique identifier of the station genre.
  public let id: MusicItemID

  /// The type of the station genre.
  public let type: String

  /// The display name of the station genre.
  public let name: String
}

/// An extension that adds `Decodable` conformance to the `StationGenre` structure.
extension StationGenre: Decodable {

  /// An enumeration of the top-level coding keys.
  enum CodingKeys: String, CodingKey {
    case attributes, id, type
  }

  /// An enumeration of the attribute-level coding keys.
  enum AttributesKey: String, CodingKey {
    case name
  }

  /// Initializes a new `StationGenre` instance from the given decoder.
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(MusicItemID.self, forKey: .id)
    type = try container.decode(String.self, forKey: .type)

    let attributesContainer = try container.nestedContainer(
      keyedBy: AttributesKey.self, forKey: .attributes)
    name = try attributesContainer.decode(String.self, forKey: .name)
  }
}

/// An extension that adds `MusicItem` conformance to the `StationGenre` structure.
extension StationGenre: MusicItem {}

/// An extension that adds `Equatable`, `Hashable`, and `Identifiable` conformances to the `StationGenre` structure.
extension StationGenre: Equatable, Hashable, Identifiable {

  /// Determines if two `StationGenre` instances are equal based on their identifiers.
  public static func == (lhs: StationGenre, rhs: StationGenre) -> Bool {
    lhs.id == rhs.id
  }

  /// Computes the hash value for a `StationGenre` instance based on its identifier.
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
