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

    let json = try data.printJSON()
    XCTAssertEqual(json, continuousTrackPostDataJSON)
  }

  func testMContinuousTrackDataEncoding() throws {
    let trackData = MContinuousTrackData(songID: "1640832991", albumID: "1640832989")

    let encodedData = try JSONEncoder().encode(trackData)
    let encodedString = String(data: encodedData, encoding: .utf8)

    XCTAssertEqual(encodedString?.replacingOccurrences(of: "\\s", with: "", options: .regularExpression), continuousTrackPostDataJSON.replacingOccurrences(of: "\\s", with: "", options: .regularExpression))
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
