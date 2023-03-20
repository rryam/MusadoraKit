//
//  Song.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 08/03/23.
//

import Foundation
import MusadoraKit

extension Song {
  static var mock: Song {
    get throws {
      let songData = """
      {
        "id":"1640832991",
        "type":"songs",
        "attributes":{
          "name":"Glimpse of Us",
          "artistName":"Joji"
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

  static var mocks: Songs {
    get throws {
      let songsData = """
{
  "data":[
    {
      "id":"1640832991",
      "type":"songs",
      "attributes":{
        "name":"Glimpse of Us",
        "artistName":"Joji"
      }
    },
    {
      "id":"1492318640",
      "type":"songs",
      "attributes":{
        "name":"Guilty Conscience",
        "artistName":"070 Shake"
      }
    }
  ]
}
""".data(using: .utf8)

      guard let songsData else {
        throw URLError(.cannotDecodeRawData)
      }

      let songs = try JSONDecoder().decode(Songs.self, from: songsData)
      return songs
    }
  }
}
