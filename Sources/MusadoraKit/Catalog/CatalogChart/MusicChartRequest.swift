//
//  MusicChartRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 26/03/22.
//

import Foundation

enum MusicChartType: String {
  case cityCharts
  case dailyGlobalTopCharts
}

/// A  chart request that your app uses to fetch charts from the Apple Music catalog
/// using the types of charts and for the genre identifier.
struct MusicChartRequest {
  /// The identifier for the genre to use in the chart results.
  var genre: MusicItemID?

  /// A limit for the number of items to return
  /// in the catalog chart response.
  var limit: Int?

  var chartType: [MusicChartType]?

  /// Creates a request to fetch charts using the list of the
  /// types of charts to include in the results.
  init(types: [MusicChartItem.Type]) {
    self.types = Set(types.map { $0.objectIdentifier }).compactMap {
      switch $0 {
      case Song.objectIdentifier:
        return "songs"
      case Album.objectIdentifier:
        return "albums"
      case MusicVideo.objectIdentifier:
        return "music-videos"
      case Playlist.objectIdentifier:
        return "playlists"
      default:
        return nil
      }
    }.joined(separator: ",")
  }

  /// Fetches charts of the requested catalog chart types that match
  /// the genre identifier of the request.
  func response() async throws -> MusicChartResponse {
    let storefront = try await MusicDataRequest.currentCountryCode
    let url = try chartsURL(storefront: storefront)
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()

    let charts = try JSONDecoder().decode(MusicCharts.self, from: response.data)
    return charts.results
  }

  private var types: String
}

extension MusicChartRequest {
  internal func chartsURL(storefront: String) throws -> URL {
    var components = AppleMusicURLComponents()
    var queryItems: [URLQueryItem] = []
    components.path = "catalog/\(storefront)/charts"

    queryItems.append(URLQueryItem(name: "types", value: types))

    if let genre = genre {
      queryItems.append(URLQueryItem(name: "genre", value: genre.rawValue))
    }

    if let limit = limit {
      queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
    }

    if let chartType = chartType, !chartType.isEmpty {
      let value = chartType.map { $0.rawValue }.joined(separator: ",")
      queryItems.append(URLQueryItem(name: "with", value: value))
    }

    components.queryItems = queryItems

    guard let url = components.url else {
      throw URLError(.badURL)
    }
    return url
  }
}
