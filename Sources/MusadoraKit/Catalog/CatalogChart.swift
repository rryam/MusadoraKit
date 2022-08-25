//
//  CatalogChart.swift
//  CatalogChart
//
//  Created by Rudrank Riyam on 22/06/22.
//

import Foundation
import MusicKit

#if compiler(>=5.7)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public enum MusicCatalogChartType {
  case songs
  case albums
  case playlists
  case musicVideos

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

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension [MusicCatalogChartType] {
  public static var all: Self {
    MusicCatalogChartType.allCases
  }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension [MusicCatalogChartKind] {
  public static var all: Self {
    MusicCatalogChartKind.allCases
  }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension MusicCatalogChartType: CaseIterable {}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public extension MusadoraKit {
  static func catalogCharts(genre: Genre? = nil,
                            kinds: [MusicCatalogChartKind] = .all,
                            types: [MusicCatalogChartType] = .all,
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: kinds, types: types, limit: limit, offset: offset)
  }

  static func catalogCharts(genre: Genre? = nil,
                            kinds: [MusicCatalogChartKind] = .all,
                            types: MusicCatalogChartType...,
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: kinds, types: types, limit: limit, offset: offset)
  }

  static func catalogCharts(genre: Genre? = nil,
                            kinds: MusicCatalogChartKind...,
                            types: MusicCatalogChartType...,
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: kinds, types: types, limit: limit, offset: offset)
  }

  static func catalogCharts(genre: Genre? = nil,
                            kinds: [MusicCatalogChartKind] = .all,
                            type: MusicCatalogChartType,
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: kinds, types: [type], limit: limit, offset: offset)
  }

  static func catalogCharts(genre: Genre? = nil,
                            kind: MusicCatalogChartKind,
                            types: [MusicCatalogChartType] = .all,
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: [kind], types: types, limit: limit, offset: offset)
  }

  static func catalogCharts(genre: Genre? = nil,
                            kind: MusicCatalogChartKind,
                            type: MusicCatalogChartType,
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    try await fetchCatalogCharts(genre: genre, kinds: [kind], types: [type], limit: limit, offset: offset)
  }

  static private func fetchCatalogCharts(genre: Genre?,
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
#endif
