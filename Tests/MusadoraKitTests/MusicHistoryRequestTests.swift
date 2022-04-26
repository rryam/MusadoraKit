//
//  MusicHistoryRequestTests.swift
//  
//
//  Created by Rudrank Riyam on 27/04/22.
//

import XCTest
@testable import MusadoraKit

class MusicHistoryRequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testHeavyRoationEndpointURL() throws {
        let request = MusicHistoryRequest(for: .heavyRotation)
        let url = try request.historyEndpointURL

        XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/history/heavy-rotation")
    }

    func testRecentlyAddedEndpointURL() throws {
        let request = MusicHistoryRequest(for: .recentlyAdded)
        let url = try request.historyEndpointURL

        XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/recently-added")

    }

    func testRecentlyPlayedEndpointURL() throws {
        let request = MusicHistoryRequest(for: .recentlyPlayed)
        let url = try request.historyEndpointURL

        XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/played")
    }

    func testRecentlyPlayedTracksEndpointURL() throws {
        let request = MusicHistoryRequest(for: .recentlyPlayedTracks)
        let url = try request.historyEndpointURL

        XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/played/tracks")
    }

    func testRecentlyPlayedStationsEndpointURL() throws {
        let request = MusicHistoryRequest(for: .recentlyPlayedStations)
        let url = try request.historyEndpointURL

        XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/recent/radio-stations")
    }
}
