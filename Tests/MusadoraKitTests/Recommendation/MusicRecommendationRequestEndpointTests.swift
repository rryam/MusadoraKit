//
//  MusicRecommendationRequestEndpointTests.swift
//  MusicRecommendationRequestEndpointTests
//
//  Created by Rudrank Riyam on 27/04/22.
//

import XCTest
@testable import MusadoraKit

class MusicRecommendationRequestEndpointTests: XCTestCase {
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

    func testDefaultRecommendationWithOverLimitEndpointURL() throws {
        var request = MusicRecommendationRequest()
        request.limit = 31

        XCTAssertThrowsError(try request.recommendationEndpointURL) { error in
            XCTAssertEqual(error as! MusadoraKitError, MusadoraKitError.recommendationOverLimit(for: 31))
        }
    }
}

