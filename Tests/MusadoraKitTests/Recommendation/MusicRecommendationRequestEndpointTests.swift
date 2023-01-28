//
//  MusicRecommendationRequestEndpointTests.swift
//  MusicRecommendationRequestEndpointTests
//
//  Created by Rudrank Riyam on 27/04/22.
//

@testable import MusadoraKit
import XCTest

class MusicRecommendationRequestEndpointTests: XCTestCase {
  func testDefaultRecommendationEndpointURL() throws {
    let request = MRecommendationRequest()
    let url = try request.recommendationEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recommendations")
  }

  func testDefaultRecommendationWithLimitEndpointURL() throws {
    var request = MRecommendationRequest()
    request.limit = 5
    let url = try request.recommendationEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recommendations?limit=5")
  }

  func testRecommendationByIDEndpointURL() throws {
    let request = MRecommendationRequest(equalTo: "6-27s5hU6azhJY")
    let url = try request.recommendationEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recommendations?ids=6-27s5hU6azhJY")
  }

  func testDefaultRecommendationEndpointURLWithOverLimit() throws {
    let limit = 31
    var request = MRecommendationRequest()
    request.limit = limit

    XCTAssertThrowsError(try request.recommendationEndpointURL) { recommendationOverLimitError in
      let error = MusadoraKitError.recommendationOverLimit(for: limit)
      XCTAssertEqual(recommendationOverLimitError as? MusadoraKitError, error)
    }
  }
}
