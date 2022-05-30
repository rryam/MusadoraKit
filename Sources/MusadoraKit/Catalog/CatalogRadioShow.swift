//
//  CatalogRadioShow.swift
//  CatalogRadioShow
//
//  Created by Rudrank Riyam on 10/04/22.
//

import MusicKit

/// A collection of radio shows.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public typealias RadioShows = MusicItemCollection<RadioShow>

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public extension MusadoraKit {
  /// Fetch a radio show from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the radio show.
  ///   - properties: Additional relationships to fetch with the radio show.
  /// - Returns: `RadioShow` matching the given identifier.
  static func catalogRadioShow(id: MusicItemID,
                               with properties: [PartialMusicAsyncProperty<RadioShow>] = []) async throws -> RadioShow
  {
    var request = MusicCatalogResourceRequest<RadioShow>(matching: \.id, equalTo: id)
    request.properties = properties
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
  static func catalogCurators(ids: [MusicItemID],
                              with properties: [PartialMusicAsyncProperty<RadioShow>] = []) async throws -> RadioShows
  {
    var request = MusicCatalogResourceRequest<RadioShow>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}
