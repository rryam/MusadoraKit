//
//  CatalogStationEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 20/03/23.
//

@testable import MusadoraKit
import MusicKit
import Testing

@Suite struct CatalogStationEndpointTests {
  @Test func personalStationEndpointURL() throws {
    let storefront = "in"
    let endpointURL = try MCatalog.personalStationURL(for: storefront)

    let url = "https://api.music.apple.com/v1/catalog/in/stations?filter%5Bidentity%5D=personal"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test func liveStationsURL() throws {
    let storefront = "in"
    let endpointURL = try MCatalog.liveStationsURL(for: storefront)
    let url = "https://api.music.apple.com/v1/catalog/in/stations?filter%5Bfeatured%5D=apple-music-live-radio"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test func genreStationsURL() throws {
    let storefront = "in"
    let endpointURL = try MCatalog.stationsURL(for: "12345", storefront: storefront)
    let url = "https://api.music.apple.com/v1/catalog/in/station-genres/12345/stations"

    expectEndpoint(endpointURL, equals: url)
  }
}
