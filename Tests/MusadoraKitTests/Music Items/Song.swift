//
//  Song.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 08/03/23.
//

import Foundation
import MusicKit

extension Song {
  static var mock: Song {
    get throws {
      let songData = """
      {
        "id": "1640832991",
        "type": "songs",
        "attributes": {
          "name": "Glimpse of Us",
          "artistName": "Joji",
        }
      }
      """.data(using: .utf8)

      guard let songData else {
        throw URLError(.cannotDecodeRawData)
      }

      let song = try JSONDecoder().decode(Song.self, from: songData)
      return song
    }
  }
}
