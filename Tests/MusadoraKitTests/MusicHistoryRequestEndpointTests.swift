//
//  MusicHistoryRequestEndpointTests.swift
//  MusicHistoryRequestEndpointTests
//
//  Created by Rudrank Riyam on 27/04/22.
//

@testable import MusadoraKit
import XCTest

class MusicHistoryRequestEndpointTests: XCTestCase {
  func testHeavyRoationEndpointURL() throws {
    let request = MusicHistoryRequest(for: .heavyRotation)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/history/heavy-rotation")
  }

  func testHeavyRoationEndpointURLWithOverLimit() throws {
    let limit = 11
    var request = MusicHistoryRequest(for: .heavyRotation)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { error in
      XCTAssertEqual(error as! MusadoraKitError, MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit))
    }
  }

  func testRecentlyAddedEndpointURL() throws {
    let request = MusicHistoryRequest(for: .recentlyAdded)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/recently-added")
  }

  func testRecentlyAddedEndpointURLWithOverLimit() throws {
    let limit = 26
    var request = MusicHistoryRequest(for: .recentlyAdded)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { error in
      XCTAssertEqual(error as! MusadoraKitError, MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit))
    }
  }

  func testRecentlyPlayedEndpointURL() throws {
    let request = MusicHistoryRequest(for: .recentlyPlayed)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/played?with=library")
  }

  func testRecentlyPlayedEndpointURLWithOffset() throws {
    var request = MusicHistoryRequest(for: .recentlyPlayed)
    request.offset = 10

    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/played?with=library&offset=10")
  }

  func testRecentlyPlayedEndpointURLWithOverLimit() throws {
    let limit = 11
    var request = MusicHistoryRequest(for: .recentlyPlayed)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { error in
      XCTAssertEqual(error as! MusadoraKitError, MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit))
    }
  }

  func testRecentlyPlayedTracksEndpointURL() throws {
    let request = MusicHistoryRequest(for: .recentlyPlayedTracks)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/played/tracks")
  }

  func testRecentlyPlayedTracksEndpointURLWithOverLimit() throws {
    let limit = 31
    var request = MusicHistoryRequest(for: .recentlyPlayedTracks)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { error in
      XCTAssertEqual(error as! MusadoraKitError, MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit))
    }
  }

  func testRecentlyPlayedStationsEndpointURL() throws {
    let request = MusicHistoryRequest(for: .recentlyPlayedStations)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/radio-stations")
  }

  func testRecentlyPlayedStationsEndpointURLWithOverLimit() throws {
    let limit = 11
    var request = MusicHistoryRequest(for: .recentlyPlayedStations)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { error in
      XCTAssertEqual(error as! MusadoraKitError, MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit))
    }
  }
}
