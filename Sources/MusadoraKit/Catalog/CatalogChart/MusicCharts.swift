//
//  MusicCharts.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation

/// The response to a request for a chart.
///
/// This structure represents the response from the Apple Music API when requesting chart data.
/// It contains the results of the chart request, which can include various types of music items like songs, albums, and playlists.
///
/// Example usage:
/// ```swift
/// let charts = try await MCatalog.charts(kinds: .dailyGlobalTop, types: .songs)
/// print(charts.results.songs)
/// ```
struct MusicCharts: Codable {
  /// A mapping of a requested type to an array of charts.
  let results: MusicChartResponse
}
