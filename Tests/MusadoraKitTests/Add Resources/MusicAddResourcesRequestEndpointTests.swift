//
//  MusicAddResourcesRequestEndpointTests.swift
//  MusicAddResourcesRequestEndpointTests
//
//  Created by Rudrank Riyam on 18/05/22.
//

@testable import MusadoraKit
import MusicKit
import XCTest

class MusicAddResourcesRequestEndpointTests: XCTestCase {
  func testAddAlbumsToLibraryEndpointURL() throws {
    let albums: [MusicItemID] = ["1577502911", "1577502912"]

    let request = MusicAddResourcesRequest(types: [.albums: albums])
    let url = try request.addResourcesEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library?ids[albums]=1577502911,1577502912")
  }

  func testAddResourcesToLibraryEndpointURL() throws {
    let albums: [MusicItemID] = ["1577502911"]
    let songs: [MusicItemID] = ["1545146511"]

    let request = MusicAddResourcesRequest(types: [.albums: albums, .songs: songs])
    let url = try request.addResourcesEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library?ids[albums]=1577502911&ids[songs]=1545146511")
  }
}
