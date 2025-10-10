//
//  CatalogChartTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 25/03/23.
//

import Testing
import MusicKit
@testable import MusadoraKit

@Suite struct CatalogChartTests {

  @Test func chartsWithSongTypeURL() async throws {
    let request = MChartRequest(types: [Song.self])
    let endpointURL = try request.chartsURL(storefront: "us")
    let url = "https://api.music.apple.com/v1/catalog/us/charts?types=songs"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test func chartsWithSongAndGenreTypeURL() async throws {
    var request = MChartRequest(types: [Song.self])
    request.genre = MusicItemID("21")
    let endpointURL = try request.chartsURL(storefront: "us")
    let url = "https://api.music.apple.com/v1/catalog/us/charts?types=songs&genre=21"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test func chartCollectionReportsNextBatchWhenCursorPresent() {
    let collection = ChartItemCollection<Song>(
      chart: "top-songs",
      name: "Top Songs",
      next: "cursor",
      items: []
    )

    #expect(collection.hasNextBatch)
  }

  @Test func chartCollectionReportsNoNextBatchWhenCursorMissing() {
    let collection = ChartItemCollection<Song>(
      chart: "top-songs",
      name: "Top Songs",
      next: nil,
      items: []
    )

    #expect(!collection.hasNextBatch)
  }
}
