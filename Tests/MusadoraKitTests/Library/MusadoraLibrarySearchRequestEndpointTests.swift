//
//  MusadoraLibrarySearchRequestEndpointTests.swift
//  MusadoraLibrarySearchRequestEndpointTests
//
//  Created by Rudrank Riyam on 01/08/22.
//

import XCTest
@testable import MusadoraKit
import MusicKit

final class MusadoraLibrarySearchRequestEndpointTests: XCTestCase {
  func testLibrarySearchWithSingleTermAndTypeAsSong() throws {
    let term = "ed"
    let request = MusadoraLibrarySearchRequest(term: term, types: [Song.self])
    let url = try request.librarySearchEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/search?term=ed&types=library-songs")
  }

  func testLibrarySearchWithSingleTermAndTypeAsMusicVideo() throws {
    let term = "MAX"
    let request = MusadoraLibrarySearchRequest(term: term, types: [MusicVideo.self])
    let url = try request.librarySearchEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/search?term=max&types=library-music-videos")
  }

  func testLibrarySearchWithSingleTermAndTypeAsSongAndArtist() throws {
    let term = "ed"
    let request = MusadoraLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    let url = try request.librarySearchEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/search?term=ed&types=library-songs,library-artists")
  }

  func testLibrarySearchWithMultipleTermsAndTypeAsSongAndArtist() throws {
    let term = "ed sheeran"
    let request = MusadoraLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    let url = try request.librarySearchEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/search?term=ed+sheeran&types=library-songs,library-artists")
  }

  func testLibrarySearchWithMultipleTermsAndTypeAsSongAndArtistWithLimit() throws {
    let term = "ed sheeran"
    var request = MusadoraLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    request.limit = 2
    let url = try request.librarySearchEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/search?term=ed+sheeran&types=library-songs,library-artists&limit=2")
  }

  func testLibrarySearchWithMultipleTermsAndTypeAsSongAndArtistWithOffset() throws {
    let term = "ed sheeran"
    var request = MusadoraLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    request.offset = 2
    let url = try request.librarySearchEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/search?term=ed+sheeran&types=library-songs,library-artists&offset=2")
  }
}
