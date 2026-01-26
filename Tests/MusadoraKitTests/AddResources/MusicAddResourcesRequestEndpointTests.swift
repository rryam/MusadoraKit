//
//  MusicAddResourcesRequestEndpointTests.swift
//  MusicAddResourcesRequestEndpointTests
//
//  Created by Rudrank Riyam on 18/05/22.
//

@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct MusicAddResourcesRequestEndpointTests {
  @Test
  func addAlbumsToLibraryEndpointURL() throws {
    let albums: [MusicItemID] = ["1577502911", "1577502912"]

    let request = MusicAddResourcesRequest([(item: .albums, value: albums)])
    let url = try request.addResourcesEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/library?ids[albums]=1577502911,1577502912")
  }

  @Test
  func addPlaylistsToLibraryEndpointURL() throws {
    let playlists: [MusicItemID] = ["1577502911"]

    let request = MusicAddResourcesRequest([(item: .playlists, value: playlists)])
    let url = try request.addResourcesEndpointURL

    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/library?ids[playlists]=1577502911")
  }

  @Test
  func addResourcesToLibraryEndpointURL() throws {
    let albums: [MusicItemID] = ["1577502911"]
    let songs: [MusicItemID] = ["1545146511"]

    let request = MusicAddResourcesRequest([(item: .albums, value: albums), (item: .songs, value: songs)])
    let url = try request.addResourcesEndpointURL

    let endpointURL = "https://api.music.apple.com/v1/me/library?ids[albums]=1577502911&ids[songs]=1545146511"
    expectEndpoint(url, equals: endpointURL)
  }

  @Test
  func addResourcesWithDuplicatesAndSorting() throws {
    // Test deduplication: same ID appears in multiple resource tuples
    // Test sorting: IDs should be sorted alphabetically
    let songs1: [MusicItemID] = ["789", "123"]  // unsorted
    let songs2: [MusicItemID] = ["123", "456"]  // duplicate "123"
    let albums: [MusicItemID] = ["999", "111"]  // unsorted

    let request = MusicAddResourcesRequest([
      (item: .songs, value: songs1),
      (item: .albums, value: albums),
      (item: .songs, value: songs2)
    ])
    let url = try request.addResourcesEndpointURL

    // Expected: albums before songs (alphabetical), IDs sorted within each type, duplicates removed
    let expectedURL = "https://api.music.apple.com/v1/me/library?ids[albums]=111,999&ids[songs]=123,456,789"
    expectEndpoint(url, equals: expectedURL)
  }

  @Test
  func addResourcesWithEmptyIdsThrows() throws {
    let request = MusicAddResourcesRequest([(item: .songs, value: [])])

    let error = #expect(throws: MusadoraKitError.self) {
      try request.addResourcesEndpointURL
    }

    #expect(error == MusadoraKitError.idMissing)
  }

  @Test
  func addResourcesWithNoResourcesThrows() throws {
    let request = MusicAddResourcesRequest([])

    let error = #expect(throws: MusadoraKitError.self) {
      try request.addResourcesEndpointURL
    }

    #expect(error == MusadoraKitError.idMissing)
  }
}
