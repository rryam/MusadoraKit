//
//  ChartItemCollection.swift
//  ChartItemCollection
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation
import MusicKit

/// A collection of chart items.
public struct ChartItemCollection<MusicItemType> where MusicItemType: MusicItem {
  /// The unique name of the chart to use when fetching a specific chart.
  public let chart: String

  /// The localized display name for the chart.
  public let name: String

  /// A relative cursor to fetch the next paginated results for the chart if more exist.
  public let next: String?

  /// The popularity-ordered music item type for the chart.
  public let items: [MusicItemType]

  enum CodingKeys: String, CodingKey {
    case chart, name
    case next
    case items = "data"
  }
}

public extension ChartItemCollection {
  /// A Boolean value that indicates whether the collection has information
  /// that allows it to fetch a subsequent batch of items.
  var hasNextBatch: Bool {
    next == nil
  }
}

extension ChartItemCollection where MusicItemType: MusadoraCatalogChart {}

extension ChartItemCollection: Decodable where MusicItemType: Decodable {}

extension ChartItemCollection: Encodable where MusicItemType: Encodable {}

extension ChartItemCollection: Equatable, Hashable {
  public static func == (lhs: ChartItemCollection<MusicItemType>, rhs: ChartItemCollection<MusicItemType>) -> Bool {
    lhs.chart == rhs.chart
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(chart)
  }
}
