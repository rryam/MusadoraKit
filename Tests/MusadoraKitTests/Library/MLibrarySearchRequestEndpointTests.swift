//
//  MLibrarySearchRequestEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 01/08/22.
//

import Testing
import MusicKit
@testable import MusadoraKit

@Suite struct MLibrarySearchRequestEndpointTests {

  @Test func librarySearchWithSingleTermAndTypeAsSong() throws {
    let term = "ed"
    let request = MLibrarySearchRequest(term: term, types: [Song.self])
    let url = try request.librarySearchEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/library/search?term=ed&types=library-songs")
  }

  @Test func librarySearchWithSingleTermAndTypeAsMusicVideo() throws {
    let term = "MAX"
    let request = MLibrarySearchRequest(term: term, types: [MusicVideo.self])
    let url = try request.librarySearchEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/library/search?term=max&types=library-music-videos")
  }

  @Test func librarySearchWithSingleTermAndTypeAsSongAndArtist() throws {
    let term = "ed"
    let request = MLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed&types=library-songs,library-artists"
    expectEndpoint(endpointURL, equals: url)
  }

  @Test func librarySearchWithMultipleTermsAndTypeAsSongAndArtist() throws {
    let term = "ed sheeran"
    let request = MLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sheeran&types=library-songs,library-artists"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test func librarySearchWithMultipleTermsAndTypeAsSongAndArtistWithLimit() throws {
    let term = "ed sh"
    var request = MLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    request.limit = 2
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sh&types=library-songs,library-artists&limit=2"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test func librarySearchWithMultipleTermsAndTypeAsSongAndArtistWithOffset() throws {
    let term = "ed sh"
    var request = MLibrarySearchRequest(term: term, types: [Song.self, Artist.self])
    request.offset = 2
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sh&types=library-songs,library-artists&offset=2"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test func librarySearchRequestsAreHashable() throws {
    var requestA = MLibrarySearchRequest(term: "ed", types: [Song.self, Artist.self])
    requestA.limit = 5
    requestA.offset = 1

    var requestB = MLibrarySearchRequest(term: "ed", types: [Song.self, Artist.self])
    requestB.limit = 5
    requestB.offset = 1

    let different = MLibrarySearchRequest(term: "ed", types: [Song.self])

    var requests: Set<MLibrarySearchRequest> = []
    requests.insert(requestA)

    #expect(requests.contains(requestB))
    #expect(!requests.contains(different))
  }
}
