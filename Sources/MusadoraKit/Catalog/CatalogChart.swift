//
//  CatalogChart.swift
//  CatalogChart
//
//  Created by Rudrank Riyam on 22/06/22.
//

import Foundation
import MusicKit

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public enum MusicCatalogChartType {
  case songs
  case albums
  case playlists
  case musicVideos

  var type: MusicCatalogChartRequestable.Type {
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
public extension MusadoraKit {
  static func catalogCharts(genre: Genre? = nil,
                            kinds: [MusicCatalogChartKind] = [.mostPlayed],
                            types: [MusicCatalogChartType],
                            limit: Int? = nil,
                            offset: Int? = nil) async throws -> MusicCatalogChartsResponse {
    let chartTypes = types.map { $0.type }

    var request = MusicCatalogChartsRequest(genre: genre, kinds: kinds, types: chartTypes)
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response
  }
}
