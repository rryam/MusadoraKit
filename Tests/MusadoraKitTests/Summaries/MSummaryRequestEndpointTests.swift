//
//  MSummaryRequestEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Codex on 02/09/25.
//

@testable import MusadoraKit
import XCTest

final class MSummaryRequestEndpointTests: XCTestCase {

  func testDefaultEndpointURL_AllViews() throws {
    let request = MSummaryRequest()
    let url = try request.endpointURL
    // Note: views are sorted alphabetically in implementation
    // Default include and extend parameters are added automatically
    XCTAssertEqualEndpoint(
      url,
      "https://api.music.apple.com/v1/me/music-summaries?filter[year]=latest&views=top-albums,top-artists,top-songs&include=artist,album,song&extend=artistBio,editorialVideo"
    )
  }

  func testEndpointURL_TopSongsOnly() throws {
    var request = MSummaryRequest()
    request.views = [.topSongs]
    let url = try request.endpointURL
    // Default include and extend parameters are added automatically
    XCTAssertEqualEndpoint(
      url,
      "https://api.music.apple.com/v1/me/music-summaries?filter[year]=latest&views=top-songs&include=artist,album,song&extend=artistBio,editorialVideo"
    )
  }

  func testEndpointURL_LanguageIncludeExtend() throws {
    var request = MSummaryRequest()
    request.views = [.topArtists]
    request.languageTag = "en-US"
    request.include = ["relationships"]
    request.extend = ["extended-attributes"]

    let url = try request.endpointURL

    // Order of query items is deterministic in our builder (filter -> views -> include -> extend -> l)
    XCTAssertEqualEndpoint(
      url,
      "https://api.music.apple.com/v1/me/music-summaries?filter[year]=latest&views=top-artists&include=relationships&extend=extended-attributes&l=en-US"
    )
  }
}

