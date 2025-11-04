//
//  MusicSummaryRequestEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Codex on 02/09/25.
//

@testable import MusadoraKit
import Testing

@Suite
struct MusicSummaryRequestEndpointTests {
  @Test
  func defaultEndpointURLAllViews() throws {
    let request = MusicSummaryRequest()
    let url = try request.endpointURL
    // Note: views are sorted alphabetically in implementation
    // Default include and extend parameters are added automatically
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/music-summaries?filter[year]=latest&views=top-albums,top-artists,top-songs&include=artist,album,song&extend=artistBio,editorialVideo")
  }

  @Test
  func endpointURLTopSongsOnly() throws {
    var request = MusicSummaryRequest()
    request.views = [.topSongs]
    let url = try request.endpointURL
    // Default include and extend parameters are added automatically
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/music-summaries?filter[year]=latest&views=top-songs&include=artist,album,song&extend=artistBio,editorialVideo")
  }

  @Test
  func endpointURLLanguageIncludeExtend() throws {
    var request = MusicSummaryRequest()
    request.views = [.topArtists]
    request.languageTag = "en-US"
    request.include = ["relationships"]
    request.extend = ["extended-attributes"]

    let url = try request.endpointURL

    // Order of query items is deterministic in our builder (filter -> views -> include -> extend -> l)
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/music-summaries?filter[year]=latest&views=top-artists&include=relationships&extend=extended-attributes&l=en-US")
  }

  @Test
  func endpointURLLatestMonth() throws {
    var request = MusicSummaryRequest()
    request.period = .month(year: 2025, month: 8)

    let url = try request.endpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/music-summaries/month-2025-8?views=top-albums,top-artists,top-songs&include=artist,album,song&extend=artistBio,editorialVideo")
  }
}
