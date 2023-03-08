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
      let stationData = """
{
  "id": "ra.1440541046",
  "type": "stations",
  "attributes": {
    "name": "Apple Music Presents: Little Mix - Live from London",
    "isLive": true
  }
}
""".data(using: .utf8)

      guard let stationData else {
        throw URLError(.cannotDecodeRawData)
      }

      let station = try JSONDecoder().decode(Station.self, from: stationData)
      return station
    }
  }
}
