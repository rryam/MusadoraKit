//
//  MusicHistoryRequestEndpointTests.swift
//  MusicHistoryRequestEndpointTests
//
//  Created by Rudrank Riyam on 01/08/22.
//

import XCTest

final class MusicHistoryRequestEndpointTests: XCTestCase {
  func testDefaultRecommendationEndpointURL() throws {
    let request = MusicRecommendationRequest()
    let url = try request.recommendationEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recommendations")
  }

  func testDefaultRecommendationWithLimitEndpointURL() throws {
    var request = MusicRecommendationRequest()
    request.limit = 5
    let url = try request.recommendationEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recommendations?limit=5")
  }

  func testRecommendationByIDEndpointURL() throws {
    let request = MusicRecommendationRequest(equalTo: "6-27s5hU6azhJY")
    let url = try request.recommendationEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recommendations?ids=6-27s5hU6azhJY")
  }
