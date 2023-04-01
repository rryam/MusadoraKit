//
//  CatalogStationGenreTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 24/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class CatalogStationGenreTests: XCTestCase {
    func testDecoding() throws {
        let jsonData = """
        {
          "id": "1",
          "type": "station",
          "attributes": {
            "name": "Pop"
          }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let stationGenre = try decoder.decode(StationGenre.self, from: jsonData)

        XCTAssertEqual(stationGenre.id, "1")
        XCTAssertEqual(stationGenre.type, "station")
        XCTAssertEqual(stationGenre.name, "Pop")
    }

    func testEquatable() {
        let stationGenre1 = StationGenre(id: "1", type: "station", name: "Pop")
        let stationGenre2 = StationGenre(id: "1", type: "station", name: "Pop")
        let stationGenre3 = StationGenre(id: "2", type: "station", name: "Rock")

        XCTAssertTrue(stationGenre1 == stationGenre2)
        XCTAssertFalse(stationGenre1 == stationGenre3)
    }

    func testHashable() {
        let stationGenre1 = StationGenre(id: "1", type: "station", name: "Pop")
        let stationGenre2 = StationGenre(id: "1", type: "station", name: "Pop")
        let stationGenre3 = StationGenre(id: "2", type: "station", name: "Rock")

        XCTAssertEqual(stationGenre1.hashValue, stationGenre2.hashValue)
        XCTAssertNotEqual(stationGenre1.hashValue, stationGenre3.hashValue)
    }

    static var allTests = [
        ("testDecoding", testDecoding),
        ("testEquatable", testEquatable),
        ("testHashable", testHashable)
    ]
}
