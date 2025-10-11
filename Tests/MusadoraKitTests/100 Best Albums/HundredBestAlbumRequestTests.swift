//
//  HundredBestAlbumRequestTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 19/05/24.
//

@testable import MusadoraKit
import Testing

@Suite
struct HundredBestAlbumRequestTests {
  @Test
  func hundredBestAlbumEndpointURL() throws {
    let request = HundredBestAlbumRequest(position: 100)
    let endpointURL = try request.albumEndpointURL

    let expectedURL = "https://100best.music.apple.com/content/us/en-us/100.json"
    #expect(endpointURL.absoluteString == expectedURL)
  }

  @Test
  func hundredBestAlbumRequest() async throws {
    let request = HundredBestAlbumRequest(position: 100)
    let album = try await request.response()

    #expect(album.title == "Body Talk")
    #expect(album.artistName == "Robyn")
    #expect(album.position == "100")
    #expect(album.id == MusicItemID("1440714879"))
  }

  @Test
  func decodingHundredBestAlbumData() throws {
    let album = try HundredBestAlbum.mock

    #expect(album.title == "Body Talk")
    #expect(album.artistName == "Robyn")
    #expect(album.url.absoluteString == "https://music.apple.com/us/album/body-talk/1440714879")
  }
}
