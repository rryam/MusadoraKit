//
//  MusicLibraryRatingRequestTests.swift
//  MusicLibraryRatingRequestTests
//
//  Created by Rudrank Riyam on 17/11/22.
//

import XCTest
import MusicKit
@testable import MusadoraKit

final class MusicLibraryRatingRequestTests: XCTestCase {
  func testAddPersonalLibraryAlbumRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MLibraryRatingRequest(for: [id], item: .album)
    let url = try request.libraryRatingsEndpointURL
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/library-albums?ids=1138988512")
  }

  func testAddPersonalLibraryPlaylistRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MLibraryRatingRequest(for: [id], item: .playlist)
    let url = try request.libraryRatingsEndpointURL
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/library-playlists?ids=1138988512")
  }

  func testAddPersonalLibrarySongRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MLibraryRatingRequest(for: [id], item: .song)
    let url = try request.libraryRatingsEndpointURL
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/library-songs?ids=1138988512")
  }

  func testAddPersonalLibraryMusicVideoRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MLibraryRatingRequest(for: [id], item: .musicVideo)
    let url = try request.libraryRatingsEndpointURL
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/library-music-videos?ids=1138988512")
  }
}
