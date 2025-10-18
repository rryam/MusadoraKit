// 
//  CatalogCurator.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/04/22.
//

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public extension MCatalog {
  /// Fetch a curator from the Apple Music catalog by using its identifier.
  ///
  /// In the following example, the method fetches the details of the curator **Zane Lowe** with the ID `991490326`.
  /// It also fetches additional relationships like `playlists` in the same request, by specifying them in the `fetch` parameter:
  ///
  ///     let id: MusicItemID = "991490326"
  ///     let curator = try await MCatalog.curator(id: id, fetch: [.playlists])
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the curator.
  ///   - properties: Additional relationships to fetch with the curator.
  /// - Returns: `Curator` matching the given identifier.
  static func curator(id: MusicItemID, fetch properties: CuratorProperties) async throws -> Curator {
    var request = MusicCatalogResourceRequest<Curator>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let curator = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return curator
  }

  /// Fetch a curator from the Apple Music catalog by using its identifier, fetching all related properties.
  ///
  /// In the following example, the method fetches the details of the curator **Zane Lowe** with the ID `991490326`.
  /// By default, it fetches all properties related to the curator in the same request:
  ///
  ///     let id: MusicItemID = "991490326"
  ///     let curator = try await MCatalog.curator(id: id)
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the curator.
  /// - Returns: `Curator` matching the given identifier along with all its related properties.
  static func curator(id: MusicItemID) async throws -> Curator {
    var request = MusicCatalogResourceRequest<Curator>(matching: \.id, equalTo: id)
    request.properties = .all
    let response = try await request.response()

    guard let curator = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return curator
  }

  /// Fetch multiple curators from the Apple Music catalog by using their identifiers.
  ///
  /// In the following example, the method fetches the details of curators **Zane Lowe** and **Ebro Darden** with the IDs `991490326` and `976439455` respectively.
  /// It also fetches additional relationships like `playlists` in the same request, by specifying them in the `fetch` parameter:
  ///
  ///     let ids: [MusicItemID] = ["991490326", "976439455"]
  ///     let curators = try await MCatalog.curators(ids: ids, fetch: [.playlists])
  ///
  /// - Parameters:
  ///   - ids: An array of unique identifiers for the curators.
  ///   - properties: Additional relationships to fetch with the curators.
  /// - Returns: `Curators` matching the given identifiers.
  static func curators(ids: [MusicItemID], fetch properties: CuratorProperties) async throws -> Curators {
    var request = MusicCatalogResourceRequest<Curator>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return try await response.items.collectingAll()
  }

  /// Fetch multiple curators from the Apple Music catalog by using their identifiers, fetching all related properties.
  ///
  /// In the following example, the method fetches the details of curators **Zane Lowe** and **Ebro Darden** with the IDs `991490326` and `976439455` respectively.
  /// By default, it fetches all properties related to the curators in the same request:
  ///
  ///     let ids: [MusicItemID] = ["991490326", "976439455"]
  ///     let curators = try await MCatalog.curators(ids: ids)
  ///
  /// - Parameters:
  ///   - ids: An array of unique identifiers for the curators.
  /// - Returns: `Curators` matching the given identifiers along with all their related properties.
  static func curators(ids: [MusicItemID]) async throws -> Curators {
    var request = MusicCatalogResourceRequest<Curator>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return try await response.items.collectingAll()
  }
}
