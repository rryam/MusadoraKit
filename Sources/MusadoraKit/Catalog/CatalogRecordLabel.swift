//
//  CatalogRecordLabel.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/04/22.
//



public extension MCatalog {
  /// Fetch a record label from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the record label.
  ///   - properties: Additional relationships to fetch with the record label.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `RecordLabel` matching the given identifier.
  static func recordLabel(id: MusicItemID, fetch properties: RecordLabelProperties) async throws -> RecordLabel {
    var request = MusicCatalogResourceRequest<RecordLabel>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let recordLabel = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return recordLabel
  }

#if compiler(>=5.7)
  /// Fetch a record label from the Apple Music catalog by using its identifier with all properties.
  /// - Parameters:
  ///   - id: The unique identifier for the record label.
  /// - Returns: `RecordLabel` matching the given identifier.
  static func recordLabel(id: MusicItemID) async throws -> RecordLabel {
    var request = MusicCatalogResourceRequest<RecordLabel>(matching: \.id, equalTo: id)
    request.properties = .all
    let response = try await request.response()

    guard let recordLabel = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return recordLabel
  }
#endif

  /// Fetch multiple record labels from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the record labels.
  ///   - properties: Additional relationships to fetch with the record labels.
  ///   Pass an empty array to avoid fetching additional properties.
  /// - Returns: `RecordLabels` matching the given identifiers.
  static func recordLabels(ids: [MusicItemID], fetch properties: RecordLabelProperties) async throws -> RecordLabels {
    var request = MusicCatalogResourceRequest<RecordLabel>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

#if compiler(>=5.7)
  /// Fetch multiple record labels from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the record labels.
  /// - Returns: `RecordLabels` matching the given identifiers.
  static func recordLabels(ids: [MusicItemID]) async throws -> RecordLabels {
    var request = MusicCatalogResourceRequest<RecordLabel>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return response.items
  }
#endif
}
