//
//  CatalogPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

import Foundation

public extension MCatalog {

  /// Fetch a playlist from the Apple Music catalog by using its identifier.
  ///
  /// In the following example, the method fetches the details of the playlist **Bollywood Hits**
  /// with the ID `pl.d60caf02fcce4d7e9788fe01243b7c2c`.
  /// It also fetches additional relationships like `featuredArtists` and `tracks` in the
  /// same request, by specifying them in the `fetch` parameter:
  ///
  ///     let id: MusicItemID = "pl.d60caf02fcce4d7e9788fe01243b7c2c"
  ///     let playlist = try await MCatalog.playlist(id: id, fetch: [.featuredArtists, .tracks])
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  ///   - properties: Additional relationships to fetch with the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  static func playlist(id: MusicItemID, fetch properties: PlaylistProperties) async throws -> Playlist {
    try await playlist(id: id, properties: properties)
  }

  /// Fetch a playlist from the Apple Music catalog by using its identifier.
  ///
  /// In the following example, the method fetches the details of the playlist **Bollywood Essentials**
  /// by Apple Music Bollywood with the ID `pl.c7be009ba325420394d51269b3c4a9fe` and a
  /// single relationship `moreByCurator` to fetch in the same request:
  ///
  ///     let id: MusicItemID = "pl.c7be009ba325420394d51269b3c4a9fe"
  ///     let playlist = try await MCatalog.playlist(id: id, fetch: .moreByCurator)
  ///
  /// To fetch additional relationships like `radioShow` and `curator` in the same request,
  /// specify them in the `fetch` parameter:
  ///
  ///     let id: MusicItemID = "pl.c7be009ba325420394d51269b3c4a9fe"
  ///     let playlist = try await MCatalog.playlist(id: id, fetch: .radioShow, .curator)
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  ///   - properties: Additional relationships to fetch with the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  ///
  /// - Note: It is a personal preference to either use the method where the `fetch` parameter takes an array of
  ///  `PlaylistProperty` or as a variadic parameter.
  static func playlist(id: MusicItemID, fetch properties: PlaylistProperty...) async throws -> Playlist {
    try await playlist(id: id, properties: properties)
  }

  /// Fetch a playlist from the Apple Music catalog by using its identifier.
  ///
  /// In the following example, the method fetches the details of the playlist **Verified Hits**
  /// by Apple Music Pop with the ID `pl.c189b515739547ab93ce464867bb3e09` and a
  /// single relationship `moreByCurator` to fetch in the same request:
  ///
  ///     let id: MusicItemID = "pl.c189b515739547ab93ce464867bb3e09e"
  ///     let playlist = try await MCatalog.playlist(id: id, fetch: .moreByCurator)
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  ///   - properties: Additional relationships to fetch with the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  ///
  /// - Note: Use this method when you have to fetch only one particular relationship.
  static func playlist(id: MusicItemID, fetch property: PlaylistProperty) async throws -> Playlist {
    try await playlist(id: id, properties: [property])
  }

  /// Fetch a playlist from the Apple Music catalog by using its identifier with no properties.
  ///
  /// In the following example, the method fetches the details of the playlist **Today's Hits**
  /// by Apple Music Hits with the ID `pl.f4d106fed2bd41149aaacabb233eb5eb`:
  ///
  ///     let id: MusicItemID = "pl.f4d106fed2bd41149aaacabb233eb5eb"
  ///     let playlist = try await MCatalog.playlist(id: id)
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  ///
  /// - Note: Use this method when you want a faster response with no
  /// additional properties to fetch with the playlist.
  static func playlist(id: MusicItemID) async throws -> Playlist {
    try await playlist(id: id, properties: [])
  }

  /// Fetch multiple playlists from the Apple Music catalog by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  ///   - properties: Additional relationships to fetch with the playlists.
  /// - Returns: `Playlists` matching the given identifiers.
  static func playlists(ids: [MusicItemID], fetch properties: PlaylistProperties) async throws -> Playlists {
    try await playlists(ids: ids, properties: properties)
  }

  /// Fetch multiple playlists from the Apple Music catalog by using their identifiers with no properties.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  /// - Returns: `Playlists` matching the given identifiers.
  static func playlists(ids: [MusicItemID]) async throws -> Playlists {
    try await playlists(ids: ids, properties: [])
  }
}

extension MCatalog {
  static private func playlist(id: MusicItemID, properties: PlaylistProperties) async throws -> Playlist {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let playlist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return playlist
  }

  static private func playlists(ids: [MusicItemID], properties: PlaylistProperties) async throws -> Playlists {
    var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}

public extension MCatalog {

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
    let url = try chartPlaylistsURL(currentStorefront: countryCode, targetStorefront: storefront)

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
    var chunkedCountryCodes: [[String]] = [[]]

    if #available(iOS 16, tvOS 16, macOS 13, visionOS 1.0, *) {
        chunkedCountryCodes = Locale.Region.isoRegions.map { $0.identifier }.chunked(into: 10)
    } else {
      chunkedCountryCodes = Locale.isoRegionCodes.chunked(into: 10)
    }

    var globalChartPlaylists: Playlists = []

    for countryCodes in chunkedCountryCodes {
      let url = try chartPlaylistsURL(currentStorefront: countryCode, targetStorefront: countryCodes.joined(separator: ","))
      let request = MusicDataRequest(urlRequest: URLRequest(url: url))
      let response = try await request.response()

      let playlists = try JSONDecoder().decode(Playlists.self, from: response.data)

      globalChartPlaylists += playlists
    }

    return globalChartPlaylists
  }
}

extension MCatalog {
  internal static func chartPlaylistsURL(currentStorefront: String, targetStorefront: String? = nil, components: MURLComponents = AppleMusicURLComponents()) throws -> URL {
    var components = components
    components.path = "catalog/\(currentStorefront)/playlists"

    if let targetStorefront {
      components.queryItems = [URLQueryItem(name: "filter[storefront-chart]", value: targetStorefront)]
    } else {
      components.queryItems = [URLQueryItem(name: "filter[storefront-chart]", value: currentStorefront)]
    }

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
