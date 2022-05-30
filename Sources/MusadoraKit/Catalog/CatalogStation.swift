//
//  CatalogStation.swift
//  CatalogStation
//
//  Created by Rudrank Riyam on 14/08/21.
//

import Foundation
import MusicKit

/// A collection of stations.
public typealias Stations = MusicItemCollection<Station>

public extension MusadoraKit {
  /// Fetch a station from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the station.
  /// - Returns: `Station` matching the given identifier.
  static func catalogStation(id: MusicItemID) async throws -> Station {
    let request = MusicCatalogResourceRequest<Station>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let station = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return station
  }

  /// Fetch multiple stations from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifier for the stations.
  /// - Returns: `Stations` matching the given identifiers.
  static func catalogStation(ids: [MusicItemID]) async throws -> Stations {
    let request = MusicCatalogResourceRequest<Station>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return response.items
  }
}
