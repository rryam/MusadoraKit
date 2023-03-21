//
//  AppleMusicURLComponentsTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 22/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class AppleMusicURLComponentsTests: XCTestCase {
  func testInit() {
    let appleMusicURLComponents = AppleMusicURLComponents()
    let expectedURL = URL(string: "https://api.music.apple.com")

    XCTAssertNotNil(appleMusicURLComponents.url)
    XCTAssertEqual(appleMusicURLComponents.url?.scheme, "https")
    XCTAssertEqual(appleMusicURLComponents.url?.host, "api.music.apple.com")
    XCTAssertEqual(appleMusicURLComponents.url, expectedURL)
  }

  func testQueryItems() {
    var appleMusicURLComponents = AppleMusicURLComponents()
    let chartQuery = URLQueryItem(name: "filter[storefront-chart]", value: "in")
    let identityQuery = URLQueryItem(name: "filter[identity]", value: "personal")
    let queryItems: [URLQueryItem] = [chartQuery, identityQuery]
    appleMusicURLComponents.queryItems = queryItems

    XCTAssertEqual(appleMusicURLComponents.queryItems, queryItems)
  }

  func testPath() {
    var appleMusicURLComponents = AppleMusicURLComponents()
    let path = "catalog/us/songs"
    appleMusicURLComponents.path = path

    XCTAssertEqual(appleMusicURLComponents.path, "/v1/" + path)
  }

  func testURL() {
    var appleMusicURLComponents = AppleMusicURLComponents()
    let path = "catalog/us/songs"
    let idsQuery = URLQueryItem(name: "ids", value: "1234,5678")
    let relationshipQuery = URLQueryItem(name: "extend", value: "artists")
    let queryItems: [URLQueryItem] = [idsQuery, relationshipQuery]
    appleMusicURLComponents.path = path
    appleMusicURLComponents.queryItems = queryItems

    let expectedURL = URL(string: "https://api.music.apple.com/v1/catalog/us/songs?ids=1234,5678&extend=artists")
    XCTAssertEqual(appleMusicURLComponents.url, expectedURL)
  }
}
