//
//  MStationTrackRequestEndpointTests.swift
//  MusadoraKitTests
//
//
//  Created by Rudrank Riyam on 08/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class MStationTrackRequestEndpointTests: XCTestCase {
  func testStationTracksEndpointURL() throws {
    let station = try Station.mock
    let request = MStationTrackRequest(for: station)
    let endpointURL = try request.stationTracksEndpointURL
    let url = "https://api.music.apple.com/v1/me/stations/next-tracks/ra.1440541046?limit=10"
    XCTAssertEqualEndpoint(endpointURL, url)
  }
}
