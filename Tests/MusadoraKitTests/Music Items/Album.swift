//
//  Album.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 08/03/23.
//

import Foundation
import MusicKit

extension Album {
  static var mock: Album {
    get throws {
      let albumData = """
{
  "id": "1640832989",
  "type": "albums",
  "attributes": {
    "name": "SMITHEREENS",
    "artistName": "Joji"
  }
}
""".data(using: .utf8)

      guard let albumData else {
        throw URLError(.cannotDecodeRawData)
      }

      let album = try JSONDecoder().decode(Album.self, from: albumData)
      return album
    }
  }
}
