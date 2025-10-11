//
//  CatalogStationGenreTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 24/03/23.
//

import Foundation
@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct CatalogStationGenreTests {
  @Test
  func decoding() throws {
    let jsonString = """
    {
      "id": "1",
      "type": "station",
      "attributes": {
        "name": "Pop"
      }
    }
    """
    let jsonData = Data(jsonString.utf8)

    let decoder = JSONDecoder()
    let stationGenre = try decoder.decode(StationGenre.self, from: jsonData)

    #expect(stationGenre.id == "1")
    #expect(stationGenre.type == "station")
    #expect(stationGenre.name == "Pop")
  }

  @Test
  func equatable() {
    let stationGenre1 = StationGenre(id: "1", type: "station", name: "Pop")
    let stationGenre2 = StationGenre(id: "1", type: "station", name: "Pop")
    let stationGenre3 = StationGenre(id: "2", type: "station", name: "Rock")

    #expect(stationGenre1 == stationGenre2)
    #expect(stationGenre1 != stationGenre3)
  }

  @Test
  func hashable() {
    let stationGenre1 = StationGenre(id: "1", type: "station", name: "Pop")
    let stationGenre2 = StationGenre(id: "1", type: "station", name: "Pop")
    let stationGenre3 = StationGenre(id: "2", type: "station", name: "Rock")

    #expect(stationGenre1.hashValue == stationGenre2.hashValue)
    #expect(stationGenre1.hashValue != stationGenre3.hashValue)
  }
}
