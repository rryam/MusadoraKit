//
//  MusicSearchLibraryRequestEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 01/08/22.
//

@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct MusicSearchLibraryRequestEndpointTests {
  @Test
  func librarySearchWithSingleTermAndTypeAsSong() throws {
    let term = "ed"
    let request = MusicSearchLibraryRequest(term: term, types: [Song.self])
    let url = try request.librarySearchEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/library/search?term=ed&types=library-songs")
  }

  @Test
  func librarySearchWithSingleTermAndTypeAsMusicVideo() throws {
    let term = "MAX"
    let request = MusicSearchLibraryRequest(term: term, types: [MusicVideo.self])
    let url = try request.librarySearchEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/library/search?term=max&types=library-music-videos")
  }

  @Test
  func librarySearchWithSingleTermAndTypeAsSongAndArtist() throws {
    let term = "ed"
    let request = MusicSearchLibraryRequest(term: term, types: [Song.self, Artist.self])
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed&types=library-songs,library-artists"
    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func librarySearchWithMultipleTermsAndTypeAsSongAndArtist() throws {
    let term = "ed sheeran"
    let request = MusicSearchLibraryRequest(term: term, types: [Song.self, Artist.self])
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sheeran&types=library-songs,library-artists"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func librarySearchWithMultipleTermsAndTypeAsSongAndArtistWithLimit() throws {
    let term = "ed sh"
    var request = MusicSearchLibraryRequest(term: term, types: [Song.self, Artist.self])
    request.limit = 2
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sh&types=library-songs,library-artists&limit=2"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func librarySearchWithMultipleTermsAndTypeAsSongAndArtistWithOffset() throws {
    let term = "ed sh"
    var request = MusicSearchLibraryRequest(term: term, types: [Song.self, Artist.self])
    request.offset = 2
    let endpointURL = try request.librarySearchEndpointURL
    let url = "https://api.music.apple.com/v1/me/library/search?term=ed+sh&types=library-songs,library-artists&offset=2"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func librarySearchRequestsAreHashable() throws {
    var requestA = MusicSearchLibraryRequest(term: "ed", types: [Song.self, Artist.self])
    requestA.limit = 5
    requestA.offset = 1

    var requestB = MusicSearchLibraryRequest(term: "ed", types: [Song.self, Artist.self])
    requestB.limit = 5
    requestB.offset = 1

    let different = MusicSearchLibraryRequest(term: "ed", types: [Song.self])

    var requests: Set<MusicSearchLibraryRequest> = []
    requests.insert(requestA)

    #expect(requests.contains(requestB))
    #expect(!requests.contains(different))
  }
}
