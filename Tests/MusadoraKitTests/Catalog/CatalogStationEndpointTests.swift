//
//  CatalogStationEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 20/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class CatalogStationEndpointTests: XCTestCase {
  func testPersonalStationEndpointURL() throws {
    let storefront = "in"
    let endpointURL = try MCatalog.personalStationURL(for: storefront)
    print(endpointURL)

    let url = "https://api.music.apple.com/v1/catalog/in/stations?filter%5Bidentity%5D=personal"

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testLiveStationsURL() throws {
    let storefront = "in"
    let endpointURL = try MCatalog.liveStationsURL(for: storefront)
    let url = "https://api.music.apple.com/v1/catalog/in/stations?filter%5Bfeatured%5D=apple-music-live-radio"

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testGenreStationsURL() throws {
    let storefront = "in"
    let endpointURL = try MCatalog.stationsURL(for: "12345", storefront: storefront)
    let url = "https://api.music.apple.com/v1/catalog/in/station-genres/12345/stations"

    XCTAssertEqualEndpoint(endpointURL, url)
  }
}
