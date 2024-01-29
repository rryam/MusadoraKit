//
//  MContinuousTrackRequestTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 08/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class MContinuousTrackRequestTests: XCTestCase {
  func testContinuousTracksEndpointURL() throws {
    let song = try Song.mock
    let request = MContinuousTrackRequest(for: song)
    let endpointURL = try request.continuousTracksEndpointURL
    let url = "https://api.music.apple.com/v1/me/stations/continuous?limit[results:tracks]=10&with=tracks"
    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testContinuousTracksRequestData() throws {
    let song = try Song.mock
    let album = try Album.mock

    let request = MContinuousTrackRequest(for: song)
    let postRequest = try request.createPostRequest(for: song, album: album)

    guard let data = postRequest.data else {
      throw URLError(.cannotDecodeRawData)
    }

    let decodedData = try JSONDecoder().decode(MContinuousTrackData.self, from: data)
    let expectedData = MContinuousTrackData(songID: song.id, albumID: album.id)

    XCTAssertEqual(decodedData, expectedData)
  }

  func testMContinuousTrackDataEncoding() throws {
    let trackData = MContinuousTrackData(songID: "1640832991", albumID: "1640832989")

    let encodedData = try JSONEncoder().encode(trackData)
    let decodedData = try JSONDecoder().decode(MContinuousTrackData.self, from: encodedData)

    let expectedData = MContinuousTrackData(songID: "1640832991", albumID: "1640832989")

    XCTAssertEqual(decodedData, expectedData)
  }
}

private let continuousTrackPostDataJSON = """
{
  "data" : [
    {
      "id" : "1640832991",
      "type" : "songs",
      "meta" : {
        "container" : {
          "id" : "1640832989",
          "type" : "albums"
        }
      }
    }
  ]
}
"""
