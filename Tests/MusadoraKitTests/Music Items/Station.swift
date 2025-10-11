//
//  Station.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 08/03/23.
//

import Foundation
import MusicKit

extension Station {
  static var mock: Station {
    get throws {
      let stationData = try loadFixture(named: "station_mock")
      let station = try JSONDecoder().decode(Station.self, from: stationData)
      return station
    }
  }
}

private func loadFixture(named name: String) throws -> Data {
  guard let url = Bundle.module.url(forResource: name, withExtension: "json") else {
    throw URLError(.fileDoesNotExist)
  }
  return try Data(contentsOf: url)
}
