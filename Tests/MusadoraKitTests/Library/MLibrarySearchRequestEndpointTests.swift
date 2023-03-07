//
//  MLibrarySearchRequestEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 01/08/22.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class MLibrarySearchRequestEndpointTests: XCTestCase {
  func testLibrarySearchWithSingleTermAndTypeAsSong() throws {
    let term = "ed"
    let request = MLibrarySearchRequest(term: term, types: [Song.self])
    let url = try request.librarySearchEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/search?term=ed&types=library-songs")
  }

  func testLibrarySearchWithSingleTermAndTypeAsMusicVideo() throws {
    let term = "MAX"
    let request = MLibrarySearchRequest(term: term, types: [MusicVideo.self])
    let url = try request.librarySearchEndpointURL

    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/library/search?term=max&types=library-music-videos")
  }

  func testLibrarySearchWithSingleTermAndTypeAsSongAndArtist() throws {
    let term = "ed"
    let request = MLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed&types=library-songs,library-artists"
    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testLibrarySearchWithMultipleTermsAndTypeAsSongAndArtist() throws {
    let term = "ed sheeran"
    let request = MLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sheeran&types=library-songs,library-artists"

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testLibrarySearchWithMultipleTermsAndTypeAsSongAndArtistWithLimit() throws {
    let term = "ed sh"
    var request = MLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    request.limit = 2
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sh&types=library-songs,library-artists&limit=2"

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testLibrarySearchWithMultipleTermsAndTypeAsSongAndArtistWithOffset() throws {
    let term = "ed sh"
    var request = MLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    request.offset = 2
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sh&types=library-songs,library-artists&offset=2"

    XCTAssertEqualEndpoint(endpointURL, url)
  }
}
