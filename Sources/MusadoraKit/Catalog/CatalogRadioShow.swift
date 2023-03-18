//
//  CatalogRadioShow.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/04/22.
//

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
public extension MCatalog {
  /// Fetch a radio show from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the radio show.
  ///   - properties: Additional relationships to fetch with the radio show.
  /// - Returns: `RadioShow` matching the given identifier.
  static func radioShow(id: MusicItemID, fetch properties: RadioShowProperties) async throws -> RadioShow {
    var request = MusicCatalogResourceRequest<RadioShow>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let radioShow = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return radioShow
  }

  /// Fetch a radio show from the Apple Music catalog by using its identifier with all properties.
  /// - Parameters:
  ///   - id: The unique identifier for the radio show.
  /// - Returns: `RadioShow` matching the given identifier.
  static func radioShow(id: MusicItemID) async throws -> RadioShow {
    var request = MusicCatalogResourceRequest<RadioShow>(matching: \.id, equalTo: id)
    request.properties = .all
    let response = try await request.response()

    guard let radioShow = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return radioShow
  }

  /// Fetch multiple radio shows from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the radio shows.
  ///   - properties: Additional relationships to fetch with the radio shows.
  /// - Returns: `RadioShows` matching the given identifiers.
  static func radioShows(ids: [MusicItemID], fetch properties: RadioShowProperties) async throws -> RadioShows {
    var request = MusicCatalogResourceRequest<RadioShow>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple radio shows from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the radio shows.
  /// - Returns: `RadioShows` matching the given identifiers.
  static func radioShows(ids: [MusicItemID]) async throws -> RadioShows {
    var request = MusicCatalogResourceRequest<RadioShow>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return response.items
  }
}
