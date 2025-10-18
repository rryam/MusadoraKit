// 
//  CatalogChart.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/06/22.
//

/// Represents types of music catalog charts available in Apple Music.
///
/// These types can be songs, albums, playlists or music videos.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public enum MusicCatalogChartType {
  case songs
  case albums
  case playlists
  case musicVideos

  /// The type associated with the `MusicCatalogChartType`.
  ///
  /// - Returns: The type `MusicCatalogChartRequestable.Type` associated with the `MusicCatalogChartType`.
  public var type: MusicCatalogChartRequestable.Type {
    switch self {
    case .songs:
      return Song.self
    case .albums:
      return Album.self
    case .playlists:
      return Playlist.self
    case .musicVideos:
      return MusicVideo.self
    }
  }
}

/// Extension that provides a static var for all cases of `MusicCatalogChartType`.
///
/// - Returns: An array with all cases of `MusicCatalogChartType`.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public extension [MusicCatalogChartType] {
  static var all: Self {
    MusicCatalogChartType.allCases
  }
}

/// Extension that provides a static var for all cases of `MusicCatalogChartKind`.
///
/// - Returns: An array with all cases of `MusicCatalogChartKind`.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public extension [MusicCatalogChartKind] {
  static var all: Self {
    MusicCatalogChartKind.allCases
  }
}

/// An extension to `MusicCatalogChartType` to conform to `CaseIterable`.
///
/// This allows for easy access to all cases of `MusicCatalogChartType`, useful for iteration or creating arrays with all cases.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogChartType: CaseIterable {}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
public extension MCatalog {
  /// Fetches the charts from the Apple Music catalog.
  ///
  /// For example, here's how you can fetch the most played rock songs:
  ///
  /// ```swift
  /// do {
  ///     let rockGenre = ...
  ///     let rockCharts = try await MCatalog.charts(genre: rockGenre, kinds: [.mostPlayed], types: [.songs])
  ///     print(rockCharts)
  /// } catch {
  ///     print("Failed to fetch rock charts: \(error)")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - genre: The specific genre for the charts. Default is `nil`, fetching charts from all genres.
  ///   - kinds: An array of chart kinds. Default is `.all`, fetching all kinds of charts.
  ///   - types: An array of chart types. Default is `.all`, fetching all types of charts.
  ///   - limit: The maximum number of items to fetch. Default is `nil`, fetching as many items as possible.
  ///   - offset: The number of items to skip before beginning to fetch. Default is `nil`, starting fetching from the first item.
  /// - Returns: A `MusicCatalogChartsResponse` object containing the fetched charts.
  /// - Throws: An error if there was an issue fetching the charts.
  static func charts(genre: Genre? = nil,
                     kinds: [MusicCatalogChartKind] = .all,
                     types: [MusicCatalogChartType] = .all,
                     limit: Int? = nil,
                     offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: kinds, types: types, limit: limit, offset: offset)
  }

  /// Fetches the charts from the Apple Music catalog. Variadic version for `types`.
  ///
  /// This function provides flexibility in fetching charts for multiple `MusicCatalogChartType` but for all `MusicCatalogChartKind` or a specific `MusicCatalogChartKind`.
  ///
  /// Here's an example of fetching the most played and daily global top songs in the pop genre:
  /// ```swift
  /// do {
  ///   let popGenre = ...
  ///   let charts = try await MCatalog.charts(genre: popGenre, kinds: .mostPlayed, types: .songs, .albums)
  ///   print(charts)
  /// } catch {
  ///   print("Failed to fetch charts: \(error)")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - genre: The specific genre for the charts. Default is `nil`, fetching charts from all genres.
  ///   - kinds: An array of chart kinds or `.all` for all kinds.
  ///   - types: Variadic parameter for chart types.
  ///   - limit: The maximum number of items to fetch. Default is `nil`, fetching as many items as possible.
  ///   - offset: The number of items to skip before beginning to fetch. Default is `nil`, starting fetching from the first item.
  /// - Returns: A `MusicCatalogChartsResponse` object containing the fetched charts.
  /// - Throws: An error if there was an issue fetching the charts.
  static func charts(genre: Genre? = nil,
                     kinds: [MusicCatalogChartKind] = .all,
                     types: MusicCatalogChartType...,
                     limit: Int? = nil,
                     offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: kinds, types: types, limit: limit, offset: offset)
  }

  /// Fetches the charts from the Apple Music catalog. Variadic version for `kinds` and `types`.
  ///
  /// Here's an example of fetching the daily global top albums:
  /// ```swift
  /// do {
  ///   let globalTopAlbums = try await MCatalog.charts(kinds: .dailyGlobalTop, types: .albums)
  ///   print(globalTopAlbums)
  /// } catch {
  ///   print("Failed to fetch global top albums: \(error)")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - genre: The specific genre for the charts. Default is `nil`, fetching charts from all genres.
  ///   - kinds: Variadic parameter for chart kinds.
  ///   - types: Variadic parameter for chart types.
  ///   - limit: The maximum number of items to fetch. Default is `nil`, fetching as many items as possible.
  ///   - offset: The number of items to skip before beginning to fetch. Default is `nil`, starting fetching from the first item.
  /// - Returns: A `MusicCatalogChartsResponse` object containing the fetched charts.
  /// - Throws: An error if there was an issue fetching the charts.
  static func charts(genre: Genre? = nil,
                     kinds: MusicCatalogChartKind...,
                     types: MusicCatalogChartType...,
                     limit: Int? = nil,
                     offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: kinds, types: types, limit: limit, offset: offset)
  }

  /// Fetches the charts from the Apple Music catalog for a specific `type`.
  ///
  /// This function allows for fine-grained control by letting you specify a single `MusicCatalogChartType` while still allowing for multiple `MusicCatalogChartKind` values.
  ///
  /// Here's an example of fetching the most played rock albums:
  /// ```swift
  /// do {
  ///   let rockGenre = ...
  ///   let mostPlayedRockAlbums = try await MCatalog.charts(genre: rockGenre, kinds: [.mostPlayed], type: .albums)
  ///   print(mostPlayedRockAlbums)
  /// } catch {
  ///   print("Failed to fetch most played rock albums: \(error)")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - genre: The specific genre for the charts. Default is `nil`, fetching charts from all genres.
  ///   - kinds: An array of chart kinds. Default is `.all`, fetching all kinds of charts.
  ///   - type: A single chart type.
  ///   - limit: The maximum number of items to fetch. Default is `nil`, fetching as many items as possible.
  ///   - offset: The number of items to skip before beginning to fetch. Default is `nil`, starting fetching from the first item.
  /// - Returns: A `MusicCatalogChartsResponse` object containing the fetched charts.
  /// - Throws: An error if there was an issue fetching the charts.
  static func charts(genre: Genre? = nil,
                     kinds: [MusicCatalogChartKind] = .all,
                     type: MusicCatalogChartType,
                     limit: Int? = nil,
                     offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: kinds, types: [type], limit: limit, offset: offset)
  }

  /// Fetches the charts from the Apple Music catalog for a specific `kind`.
  ///
  /// This function allows for fine-grained control by letting you specify a single `MusicCatalogChartKind` while still allowing for multiple `MusicCatalogChartType` values.
  ///
  /// Here's an example of fetching the most played charts for the pop genre:
  /// ```swift
  /// do {
  ///   let popGenre = ...
  ///   let mostPlayedCharts = try await MCatalog.charts(genre: popGenre, kind: .mostPlayed, types: [.songs, .albums])
  ///   print(mostPlayedCharts)
  /// } catch {
  ///   print("Failed to fetch most played charts: \(error)")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - genre: The specific genre for the charts. Default is `nil`, fetching charts from all genres.
  ///   - kind: A single chart kind.
  ///   - types: An array of chart types. Default is `.all`, fetching all types of charts.
  ///   - limit: The maximum number of items to fetch. Default is `nil`, fetching as many items as possible.
  ///   - offset: The number of items to skip before beginning to fetch. Default is `nil`, starting fetching from the first item.
  /// - Returns: A `MusicCatalogChartsResponse` object containing the fetched charts.
  /// - Throws: An error if there was an issue fetching the charts.
  static func charts(genre: Genre? = nil,
                     kind: MusicCatalogChartKind,
                     types: [MusicCatalogChartType] = .all,
                     limit: Int? = nil,
                     offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: [kind], types: types, limit: limit, offset: offset)
  }

  /// Fetches the charts from the Apple Music catalog for a specific `kind` and `type`.
  ///
  /// This function provides the most specific control by letting you specify a single `MusicCatalogChartKind` and a single `MusicCatalogChartType`.
  ///
  /// Here's an example of fetching the most played songs in the alternative genre:
  /// ```swift
  /// do {
  ///   let alternativeGenre = ...
  ///   let mostPlayedSongs = try await MCatalog.charts(genre: alternativeGenre, kind: .mostPlayed, type: .songs)
  ///   print(mostPlayedSongs)
  /// } catch {
  ///   print("Failed to fetch most played songs: \(error)")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - genre: The specific genre for the charts. Default is `nil`, fetching charts from all genres.
  ///   - kind: A single chart kind.
  ///   - type: A single chart type.
  ///   - limit: The maximum number of items to fetch. Default is `nil`, fetching as many items as possible.
  ///   - offset: The number of items to skip before beginning to fetch. Default is `nil`, starting fetching from the first item.
  /// - Returns: A `MusicCatalogChartsResponse` object containing the fetched charts.
  /// - Throws: An error if there was an issue fetching the charts.
  static func charts(genre: Genre? = nil,
                     kind: MusicCatalogChartKind,
                     type: MusicCatalogChartType,
                     limit: Int? = nil,
                     offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: [kind], types: [type], limit: limit, offset: offset)
  }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
extension MCatalog {
  private static func fetchCatalogCharts(genre: Genre?,
                                         kinds: [MusicCatalogChartKind],
                                         types: [MusicCatalogChartType],
                                         limit: Int?,
                                         offset: Int?) async throws -> MusicCatalogChartsResponse {
    let chartTypes = types.map { $0.type }
    var request = MusicCatalogChartsRequest(genre: genre, kinds: kinds, types: chartTypes)
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response
  }
}
