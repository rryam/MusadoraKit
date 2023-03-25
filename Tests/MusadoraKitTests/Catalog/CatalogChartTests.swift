//
//  CatalogChartTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 25/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class CatalogChartTests: XCTestCase {
  func testChartsWithSongTypeURL() async throws {
    let request = MChartRequest(types: [Song.self])
    let endpointURL = try request.chartsURL(storefront: "us")
    let url = "https://api.music.apple.com/v1/catalog/us/charts?types=songs"

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testChartsWithSongWithGenreTypeURL() async throws {
    var request = MChartRequest(types: [Song.self])
    request.genre = MusicItemID("21")
    let endpointURL = try request.chartsURL(storefront: "us")
    let url = "https://api.music.apple.com/v1/catalog/us/charts?types=songs&genre=21"

    XCTAssertEqualEndpoint(endpointURL, url)
  }
}
