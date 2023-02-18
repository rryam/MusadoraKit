//
//  CatalogPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit
import Foundation

public extension MCatalog {
  /// Fetch a playlist from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  ///   - properties: Additional relationships to fetch with the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  static func playlist(id: MusicItemID, fetch properties: PlaylistProperties) async throws -> Playlist {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let playlist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return playlist
  }

  /// Fetch a playlist from the Apple Music catalog by using its identifier with all properties.
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  static func playlist(id: MusicItemID) async throws -> Playlist {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
    request.properties = .all
    let response = try await request.response()

    guard let playlist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return playlist
  }

  /// Fetch multiple playlists from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  ///   - properties: Additional relationships to fetch with the playlists.
  /// - Returns: `Playlists` matching the given identifiers.
  static func playlists(ids: [MusicItemID], fetch properties: PlaylistProperties) async throws -> Playlists {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple playlists from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  /// - Returns: `Playlists` matching the given identifiers.
  static func playlists(ids: [MusicItemID]) async throws -> Playlists {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return response.items
  }
}

extension MCatalog {

  /// Fetch the charting playlists from the Apple Music catalog for the particular storefront.
  ///
  /// In the following example, the method fetches the charting playlists in India:
  ///
  ///     let playlists = try await MCatalog.chartPlaylists(storefront: "IN")
  ///
  /// If no `storefront` is provided, the method retrieves the charting playlists for the current user's storefront.
  ///
  ///     let playlists = try await MCatalog.chartPlaylists()
  ///
  /// - Parameters:
  ///   - storefront: The identifier of the storefront for which to retrieve charting playlists
  /// - Returns: `Playlists` containing an array of `Playlist` objects representing the charting playlists.
  ///
  /// - Note: As of writing this method, the charting playlists are mostly of the type `Top 100` or `Daily 100`.
  static func chartPlaylists(storefront: String? = nil) async throws -> Playlists {
    let countryCode = try await MusicDataRequest.currentCountryCode
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(countryCode)/playlists"

    if let storefront = storefront {
      components.queryItems = [URLQueryItem(name: "filter[storefront-chart]", value: storefront)]
    } else {
      components.queryItems = [URLQueryItem(name: "filter[storefront-chart]", value: countryCode)]
    }

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()

    return try JSONDecoder().decode(Playlists.self, from: response.data)
  }

  /// Fetch all the charting playlists from the Apple Music catalog for all the storefronts.
  ///
  /// In the following example, the method fetches the charting playlists globally:
  ///
  ///     let playlists = try await MCatalog.globalChartPlaylists()
  ///
  /// - Returns: `Playlists` containing an array of `Playlist` objects representing the global charting playlists.
  ///
  /// - Note: As of writing this method, the charting playlists are mostly of the type `Top 100` or `Daily 100`.
  static func globalChartPlaylists() async throws -> Playlists {
    let countryCode = try await MusicDataRequest.currentCountryCode
    let chunkedCountryCodes = Locale.isoRegionCodes.chunked(into: 10)
    var globalChartPlaylists: Playlists = []

    for countryCodes in chunkedCountryCodes {
      var components = AppleMusicURLComponents()
      components.path = "catalog/\(countryCode)/playlists"
      components.queryItems = [URLQueryItem(name: "filter[storefront-chart]", value: countryCodes.joined(separator: ","))]

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      let request = MusicDataRequest(urlRequest: URLRequest(url: url))
      let response = try await request.response()

      let playlists = try JSONDecoder().decode(Playlists.self, from: response.data)

      globalChartPlaylists += playlists
    }

    return globalChartPlaylists
  }
}

extension Array where Element == String {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
