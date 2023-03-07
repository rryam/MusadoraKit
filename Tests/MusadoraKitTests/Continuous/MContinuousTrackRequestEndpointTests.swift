//
//  MContinuousTrackRequestEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 08/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class MContinuousTrackRequestEndpointTests: XCTestCase {
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

    let json = try data.printJSON()
    XCTAssertEqual(json, continuousTrackPostDataJSON)
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
