//
//  AppleMusicURLComponentsTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 22/03/23.
//

import Foundation
import Testing
import MusicKit
@testable import MusadoraKit

@Suite struct AppleMusicURLComponentsTests {

  @Test func initializationSetsBaseURL() {
    let appleMusicURLComponents = AppleMusicURLComponents()
    let expectedURL = URL(string: "https://api.music.apple.com")

    #expect(appleMusicURLComponents.url != nil)
    #expect(appleMusicURLComponents.url?.scheme == "https")
    #expect(appleMusicURLComponents.url?.host == "api.music.apple.com")
    #expect(appleMusicURLComponents.url == expectedURL)
  }

  @Test func queryItemsAssignment() {
    var appleMusicURLComponents = AppleMusicURLComponents()
    let chartQuery = URLQueryItem(name: "filter[storefront-chart]", value: "in")
    let identityQuery = URLQueryItem(name: "filter[identity]", value: "personal")
    let queryItems: [URLQueryItem] = [chartQuery, identityQuery]
    appleMusicURLComponents.queryItems = queryItems

    #expect(appleMusicURLComponents.queryItems == queryItems)
  }

  @Test func pathPrefixesVersion() {
    var appleMusicURLComponents = AppleMusicURLComponents()
    let path = "catalog/us/songs"
    appleMusicURLComponents.path = path

    #expect(appleMusicURLComponents.path == "/v1/" + path)
  }

  @Test func buildsURLWithPathAndQueryItems() {
    var appleMusicURLComponents = AppleMusicURLComponents()
    let path = "catalog/us/songs"
    let idsQuery = URLQueryItem(name: "ids", value: "1234,5678")
    let relationshipQuery = URLQueryItem(name: "extend", value: "artists")
    let queryItems: [URLQueryItem] = [idsQuery, relationshipQuery]
    appleMusicURLComponents.path = path
    appleMusicURLComponents.queryItems = queryItems

    let expectedURL = URL(string: "https://api.music.apple.com/v1/catalog/us/songs?ids=1234,5678&extend=artists")
    #expect(appleMusicURLComponents.url == expectedURL)
  }
}
