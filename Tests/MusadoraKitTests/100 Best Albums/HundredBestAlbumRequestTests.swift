//
//  HundredBestAlbumRequestTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 19/05/24.
//

import XCTest
@testable import MusadoraKit

final class HundredBestAlbumRequestTests: XCTestCase {
  func testHundredBestAlbumEndpointURL() throws {
    let request = HundredBestAlbumRequest(position: 100)
    let endpointURL = try request.albumEndpointURL

    let expectedURL = "https://100best.music.apple.com/content/us/en-us/100.json"
    XCTAssertEqual(endpointURL.absoluteString, expectedURL)
  }

  func testHundredBestAlbumRequest() async throws {
    let request = HundredBestAlbumRequest(position: 100)
    let album = try await request.response()

    XCTAssertEqual(album.title, "Body Talk")
    XCTAssertEqual(album.artistName, "Robyn")
    XCTAssertEqual(album.position, "100")
    XCTAssertEqual(album.id, MusicItemID("1440714879"))
  }

  func testDecodingHundredBestAlbumData() throws {
    let album = try HundredBestAlbum.mock

    XCTAssertEqual(album.title, "Body Talk")
    XCTAssertEqual(album.artistName, "Robyn")
    XCTAssertEqual(album.url.absoluteString, "https://music.apple.com/us/album/body-talk/1440714879")
  }
}
