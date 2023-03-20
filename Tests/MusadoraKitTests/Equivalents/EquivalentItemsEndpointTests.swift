//
//  EquivalentItemsEndpointTests.swift
//  MusadoraKitTest
//
//  Created by Rudrank Riyam on 20/03/23.
//

import Foundation

@testable import MusadoraKit
import MusicKit
import XCTest

final class EquivalentItemsEndpointTests: XCTestCase {
  func testCleanEquivalentEndpointURL() throws {
    let storefront = "in"
    let song = try Song.mock
    let endpointURL = try song.cleanEquivalentURL(storefront: storefront, path: .songs)
    let url = "https://api.music.apple.com/v1/catalog/in/songs?filter%5Bequivalents%5D=1640832991&restrict=explicit"

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testCleanEquivalentsEndpointURL() throws {
    let storefront = "in"
    let songs = try Song.mocks
    let endpointURL = try songs.cleanEquivalentsURL(storefront: storefront, path: .songs)
    let url = "https://api.music.apple.com/v1/catalog/in/songs?filter%5Bequivalents%5D=1640832991,1492318640&restrict=explicit"

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testEquivalentEndpointURL() throws {
    let storefront = "tw"
    let song = try Song.mock
    let endpointURL = try song.equivalentURL(storefront: storefront, path: .songs)
    let url = "https://api.music.apple.com/v1/catalog/tw/songs?filter%5Bequivalents%5D=1640832991"

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testEquivalentsEndpointURL() throws {
    let storefront = "tw"
    let songs = try Song.mocks
    let endpointURL = try songs.equivalentsURL(storefront: storefront, path: .songs)
    let url = "https://api.music.apple.com/v1/catalog/tw/songs?filter%5Bequivalents%5D=1640832991,1492318640"

    XCTAssertEqualEndpoint(endpointURL, url)
  }
}
