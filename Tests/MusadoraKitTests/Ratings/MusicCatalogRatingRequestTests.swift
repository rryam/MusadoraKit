//
//  MusicCatalogRatingRequestTests.swift
//  MusicCatalogRatingRequestTests
//
//  Created by Rudrank Riyam on 17/07/22.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class MusicCatalogRatingRequestTests: XCTestCase {
  func testAddPersonalAlbumRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MCatalogRatingRequest(with: id, item: .album)
    let url = try request.url
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/albums?ids=1138988512")
  }

  func testAddPersonalSongRatingEndpointURL() throws {
    let id: MusicItemID = "907242702"
    let request = MCatalogRatingRequest(with: id, item: .song)
    let url = try request.url
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/songs?ids=907242702")
  }

  func testAddPersonalPlaylistRatingEndpointURL() throws {
    let id: MusicItemID = "907242702"
    let request = MCatalogRatingRequest(with: id, item: .playlist)
    let url = try request.url
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/playlists?ids=907242702")
  }

  func testAddPersonalMusicVideoRatingEndpointURL() throws {
    let id: MusicItemID = "907242702"
    let request = MCatalogRatingRequest(with: id, item: .musicVideo)
    let url = try request.url
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/music-videos?ids=907242702")
  }

  func testAddPersonalStationRatingEndpointURL() throws {
    let id: MusicItemID = "907242702"
    let request = MCatalogRatingRequest(with: id, item: .station)
    let url = try request.url
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/stations?ids=907242702")
  }
}
