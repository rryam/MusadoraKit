//
//  MusicHistoryRequestEndpointTests.swift
//  MusicHistoryRequestEndpointTests
//
//  Created by Rudrank Riyam on 27/04/22.
//

@testable import MusadoraKit
import Testing

@Suite
struct MusicHistoryRequestEndpointTests {
  @Test
  func heavyRotationEndpointURL() throws {
    let request = MusicHistoryRequest(for: .heavyRotation)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/history/heavy-rotation")
  }

  @Test
  func heavyRotationEndpointURLWithOverLimit() {
    let limit = 11
    var request = MusicHistoryRequest(for: .heavyRotation)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  @Test
  func recentlyAddedEndpointURL() throws {
    let request = MusicHistoryRequest(for: .recentlyAdded)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/library/recently-added")
  }

  @Test
  func recentlyAddedEndpointURLWithOverLimit() {
    let limit = 26
    var request = MusicHistoryRequest(for: .recentlyAdded)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  @Test
  func recentlyPlayedEndpointURL() throws {
    let request = MusicHistoryRequest(for: .recentlyPlayed)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recent/played?with=library")
  }

  @Test
  func recentlyPlayedEndpointURLWithOffset() throws {
    var request = MusicHistoryRequest(for: .recentlyPlayed)
    request.offset = 10

    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recent/played?with=library&offset=10")
  }

  @Test
  func recentlyPlayedEndpointURLWithOverLimit() {
    let limit = 11
    var request = MusicHistoryRequest(for: .recentlyPlayed)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  @Test
  func recentlyPlayedTracksEndpointURL() throws {
    let request = MusicHistoryRequest(for: .recentlyPlayedTracks)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recent/played/tracks")
  }

  @Test
  func recentlyPlayedTracksEndpointURLWithOverLimit() {
    let limit = 31
    var request = MusicHistoryRequest(for: .recentlyPlayedTracks)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  @Test
  func recentlyPlayedStationsEndpointURL() throws {
    let request = MusicHistoryRequest(for: .recentlyPlayedStations)
    let url = try request.historyEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recent/radio-stations")
  }

  @Test
  func recentlyPlayedStationsEndpointURLWithOverLimit() {
    let limit = 11
    var request = MusicHistoryRequest(for: .recentlyPlayedStations)
    request.limit = limit

    assertHistoryOverLimit(for: &request, overLimit: limit)
  }

  private func assertHistoryOverLimit(for request: inout MusicHistoryRequest, overLimit: Int, sourceLocation: SourceLocation = #_sourceLocation) {
    let expectedError = MusadoraKitError.historyOverLimit(limit: request.maximumLimit, overLimit: overLimit)
    let error = #expect(throws: MusadoraKitError.self, sourceLocation: sourceLocation) {
      try request.historyEndpointURL
    }
    #expect(error == expectedError, sourceLocation: sourceLocation)
  }
}
