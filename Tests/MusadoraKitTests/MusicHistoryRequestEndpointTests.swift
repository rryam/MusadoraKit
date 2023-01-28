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
    let request = MHistoryRequest(for: .heavyRotation)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/history/heavy-rotation")
  }

  func testHeavyRoationEndpointURLWithOverLimit() throws {
    let limit = 11
    var request = MHistoryRequest(for: .heavyRotation)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { historyOverLimitError in
      let error = MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit)
      XCTAssertEqual(historyOverLimitError as! MusadoraKitError, error)
    }
  }

  func testRecentlyAddedEndpointURL() throws {
    let request = MHistoryRequest(for: .recentlyAdded)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/recently-added")
  }

  func testRecentlyAddedEndpointURLWithOverLimit() throws {
    let limit = 26
    var request = MHistoryRequest(for: .recentlyAdded)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { historyOverLimitError in
      let error = MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit)
      XCTAssertEqual(historyOverLimitError as? MusadoraKitError, error)
    }
  }

  func testRecentlyPlayedEndpointURL() throws {
    let request = MHistoryRequest(for: .recentlyPlayed)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/played?with=library")
  }

  func testRecentlyPlayedEndpointURLWithOffset() throws {
    var request = MHistoryRequest(for: .recentlyPlayed)
    request.offset = 10

    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/played?with=library&offset=10")
  }

  func testRecentlyPlayedEndpointURLWithOverLimit() throws {
    let limit = 11
    var request = MHistoryRequest(for: .recentlyPlayed)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { historyOverLimitError in
      let error = MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit)
      XCTAssertEqual(historyOverLimitError as? MusadoraKitError, error)
    }
  }

  func testRecentlyPlayedTracksEndpointURL() throws {
    let request = MHistoryRequest(for: .recentlyPlayedTracks)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/played/tracks")
  }

  func testRecentlyPlayedTracksEndpointURLWithOverLimit() throws {
    let limit = 31
    var request = MHistoryRequest(for: .recentlyPlayedTracks)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { historyOverLimitError in
      let error = MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit)
      XCTAssertEqual(historyOverLimitError as? MusadoraKitError, error)
    }
  }

  func testRecentlyPlayedStationsEndpointURL() throws {
    let request = MHistoryRequest(for: .recentlyPlayedStations)
    let url = try request.historyEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/radio-stations")
  }

  func testRecentlyPlayedStationsEndpointURLWithOverLimit() throws {
    let limit = 11
    var request = MHistoryRequest(for: .recentlyPlayedStations)
    request.limit = limit

    XCTAssertThrowsError(try request.historyEndpointURL) { historyOverLimitError in
      let error = MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: limit)
      XCTAssertEqual(historyOverLimitError as? MusadoraKitError, error)
    }
  }
}
