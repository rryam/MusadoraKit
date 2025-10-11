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
      let songData = try loadFixture(named: "song_mock")
      let song = try JSONDecoder().decode(Song.self, from: songData)
      return song
    }
  }

  static var mocks: Songs {
    get throws {
      let songsData = try loadFixture(named: "songs_mock")
      let songs = try JSONDecoder().decode(Songs.self, from: songsData)
      return songs
    }
  }
}

private func loadFixture(named name: String) throws -> Data {
  guard let url = Bundle.module.url(forResource: name, withExtension: "json") else {
    throw URLError(.fileDoesNotExist)
  }
  return try Data(contentsOf: url)
}
