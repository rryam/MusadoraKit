//
//  CatalogRecordLabel.swift
//  CatalogRecordLabel
//
//  Created by Rudrank Riyam on 10/04/22.
//

import MusicKit

/// A collection of record labels.
public typealias RecordLabels = MusicItemCollection<RecordLabel>

public extension MusadoraKit {
  /// Fetch a record label from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the record label.
  ///   - properties: Additional relationships to fetch with the record label.
  /// - Returns: `RecordLabel` matching the given identifier.
  static func catalogRecordLabel(id: MusicItemID,
                                 with properties: [PartialMusicAsyncProperty<RecordLabel>] = []) async throws -> RecordLabel
  {
    var request = MusicCatalogResourceRequest<RecordLabel>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let recordLabel = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return recordLabel
  }

  /// Fetch multiple record labels from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the record labels.
  ///   - properties: Additional relationships to fetch with the record labels.
  /// - Returns: `RecordLabels` matching the given identifiers.
  static func catalogRecordLabels(ids: [MusicItemID],
                                  with properties: [PartialMusicAsyncProperty<RecordLabel>] = []) async throws -> RecordLabels
  {
    var request = MusicCatalogResourceRequest<RecordLabel>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}
