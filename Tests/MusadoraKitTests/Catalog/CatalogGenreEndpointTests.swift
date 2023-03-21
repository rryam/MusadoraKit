//
//  CatalogGenreEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 21/03/23.
//

import Foundation

@testable import MusadoraKit
import MusicKit
import XCTest

final class CatalogGenreEndpointTests: XCTestCase {
  func testTopGenresURL() throws {
    let storefront = "in"
    let url = "https://api.music.apple.com/v1/catalog/in/genres"
    let endpointURL = try MCatalog.topGenresURL(storefront: storefront)

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testStationGenresURL() throws {
    let storefront = "in"
    let url = "https://api.music.apple.com/v1/catalog/in/station-genres"
    let endpointURL = try MCatalog.stationGenresURL(storefront: storefront)

    XCTAssertEqualEndpoint(endpointURL, url)
  }
}
