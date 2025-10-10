//
//  MusicRecommendationRequestEndpointTests.swift
//  MusicRecommendationRequestEndpointTests
//
//  Created by Rudrank Riyam on 27/04/22.
//

import Testing
@testable import MusadoraKit

@Suite struct MusicRecommendationRequestEndpointTests {

  @Test func defaultRecommendationEndpointURL() throws {
    let request = MRecommendationRequest()
    let url = try request.recommendationEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recommendations")
  }

  @Test func defaultRecommendationWithLimitEndpointURL() throws {
    var request = MRecommendationRequest()
    request.limit = 5
    let url = try request.recommendationEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recommendations?limit=5")
  }

  @Test func recommendationByIDEndpointURL() throws {
    let request = MRecommendationRequest(equalTo: "6-27s5hU6azhJY")
    let url = try request.recommendationEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recommendations?ids=6-27s5hU6azhJY")
  }

  @Test func recommendationByIDWithLimitEndpointURL() throws {
    var request = MRecommendationRequest(equalTo: "6-27s5hU6azhJY")
    request.limit = 2
    let url = try request.recommendationEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/recommendations?ids=6-27s5hU6azhJY&limit=2")
  }

  @Test func defaultRecommendationEndpointURLWithOverLimit() {
    let limit = 31
    var request = MRecommendationRequest()
    request.limit = limit

    let error = #expect(throws: MusadoraKitError.self) {
      try request.recommendationEndpointURL
    }
    #expect(error == MusadoraKitError.recommendationOverLimit(for: limit))
  }
}
