//
//  MusicLibraryRatingRequestTests.swift
//  MusicLibraryRatingRequestTests
//
//  Created by Rudrank Riyam on 17/11/22.
//

@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct MusicLibraryRatingRequestTests {
  @Test
  func addPersonalLibraryAlbumRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MLibraryRatingRequest(with: [id], item: .album)
    let url = try request.libraryRatingsEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/ratings/library-albums?ids=1138988512")
  }

  @Test
  func addPersonalLibraryPlaylistRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MLibraryRatingRequest(with: [id], item: .playlist)
    let url = try request.libraryRatingsEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/ratings/library-playlists?ids=1138988512")
  }

  @Test
  func addPersonalLibrarySongRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MLibraryRatingRequest(with: [id], item: .song)
    let url = try request.libraryRatingsEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/ratings/library-songs?ids=1138988512")
  }

  @Test
  func addPersonalLibraryMusicVideoRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MLibraryRatingRequest(with: [id], item: .musicVideo)
    let url = try request.libraryRatingsEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/ratings/library-music-videos?ids=1138988512")
  }
}
