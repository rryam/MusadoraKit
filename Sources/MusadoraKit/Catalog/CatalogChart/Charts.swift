//
//  Charts.swift
//  Charts
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation

/// The response to a request for a chart.
struct Charts: Codable {

    /// A mapping of a requested type to an array of charts.
    let results: MusicCatalogChartResponse
}
