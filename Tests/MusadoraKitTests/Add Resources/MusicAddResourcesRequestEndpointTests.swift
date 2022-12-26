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

    let request = MAddResourcesRequest([(item: .albums, value: albums)])
    let url = try request.addResourcesEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library?ids[albums]=1577502911,1577502912")
  }

  func testAddPlaylistsToLibraryEndpointURL() throws {
    let playlists: [MusicItemID] = ["1577502911"]

    let request = MAddResourcesRequest([(item: .playlists, value: playlists)])
    let url = try request.addResourcesEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library?ids[playlists]=1577502911")
  }

  func testAddResourcesToLibraryEndpointURL() throws {
    let albums: [MusicItemID] = ["1577502911"]
    let songs: [MusicItemID] = ["1545146511"]

    let request = MAddResourcesRequest([(item: .albums, value: albums), (item: .songs, value: songs)])
    let url = try request.addResourcesEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library?ids[albums]=1577502911&ids[songs]=1545146511")
  }
}
