//
//  MusicCatalogRatingAddRequestTests.swift
//  MusicCatalogRatingAddRequestTests
//
//  Created by Rudrank Riyam on 17/07/22.
//

import XCTest
import MusicKit
@testable import MusadoraKit

final class MusicCatalogRatingAddRequestTests: XCTestCase {
  func testAddPersonalAlbumRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MusicCatalogRatingRequest<Album>(matching: \.id, equalTo: id)
    let url = try request.catalogRatingsEndpointURL
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/albums?ids=1138988512")
  }

  func testAddPersonalSongRatingEndpointURL() throws {
    let id: MusicItemID = "907242702"
    let request = MusicCatalogRatingRequest<Song>(matching: \.id, equalTo: id)
    let url = try request.catalogRatingsEndpointURL
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/songs?ids=907242702")
  }

  func testAddPersonalPlaylistRatingEndpointURL() throws {
    let id: MusicItemID = "907242702"
    let request = MusicCatalogRatingRequest<Playlist>(matching: \.id, equalTo: id)
    let url = try request.catalogRatingsEndpointURL
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/playlists?ids=907242702")
  }
}
