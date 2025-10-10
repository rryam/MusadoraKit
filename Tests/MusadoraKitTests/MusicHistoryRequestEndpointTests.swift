//
//  MusicHistoryRequestEndpointTests.swift
//  MusicHistoryRequestEndpointTests
//
//  Created by Rudrank Riyam on 27/04/22.
//

import Testing
@testable import MusadoraKit

@Suite struct MusicHistoryRequestEndpointTests {

  @Test func heavyRotationEndpointURL() throws {
    let request = MHistoryRequest(for: .heavyRotation)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/history/heavy-rotation")
  }

  @Test func heavyRotationEndpointURLWithOverLimit() {
    let limit = 11
    var request = MHistoryRequest(for: .heavyRotation)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  @Test func recentlyAddedEndpointURL() throws {
    let request = MHistoryRequest(for: .recentlyAdded)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/library/recently-added")
  }

  @Test func recentlyAddedEndpointURLWithOverLimit() {
    let limit = 26
    var request = MHistoryRequest(for: .recentlyAdded)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  @Test func recentlyPlayedEndpointURL() throws {
    let request = MHistoryRequest(for: .recentlyPlayed)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recent/played?with=library")
  }

  @Test func recentlyPlayedEndpointURLWithOffset() throws {
    var request = MHistoryRequest(for: .recentlyPlayed)
    request.offset = 10

    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recent/played?with=library&offset=10")
  }

  @Test func recentlyPlayedEndpointURLWithOverLimit() {
    let limit = 11
    var request = MHistoryRequest(for: .recentlyPlayed)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  @Test func recentlyPlayedTracksEndpointURL() throws {
    let request = MHistoryRequest(for: .recentlyPlayedTracks)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recent/played/tracks")
  }

  @Test func recentlyPlayedTracksEndpointURLWithOverLimit() {
    let limit = 31
    var request = MHistoryRequest(for: .recentlyPlayedTracks)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  @Test func recentlyPlayedStationsEndpointURL() throws {
    let request = MHistoryRequest(for: .recentlyPlayedStations)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recent/radio-stations")
  }

  @Test func recentlyPlayedStationsEndpointURLWithOverLimit() {
    let limit = 11
    var request = MHistoryRequest(for: .recentlyPlayedStations)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  private func assertHistoryOverLimit(for request: inout MHistoryRequest, overLimit: Int, sourceLocation: SourceLocation = #_sourceLocation) {
    let expectedError = MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: overLimit)
    let error = #expect(throws: MusadoraKitError.self, sourceLocation: sourceLocation) {
      try request.historyEndpointURL
    }
    #expect(error == expectedError, sourceLocation: sourceLocation)
  }
}
