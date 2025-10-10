//
//  CatalogGenreEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 21/03/23.
//

import Foundation
import Testing
import MusicKit
@testable import MusadoraKit

@Suite struct CatalogGenreEndpointTests {

  @Test func topGenresURL() throws {
    let storefront = "in"
    let url = "https://api.music.apple.com/v1/catalog/in/genres"
    let endpointURL = try MCatalog.topGenresURL(storefront: storefront)

    expectEndpoint(endpointURL, equals: url)
  }

  @Test func stationGenresURL() throws {
    let storefront = "in"
    let url = "https://api.music.apple.com/v1/catalog/in/station-genres"
    let endpointURL = try MCatalog.stationGenresURL(storefront: storefront)

    expectEndpoint(endpointURL, equals: url)
  }
}
