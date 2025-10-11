//
//  Album.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 08/03/23.
//

import Foundation
import MusadoraKit
import MusicKit

extension Album {
  static var mock: Album {
    get throws {
      let albumData = try loadFixture(named: "album_mock")
      let album = try JSONDecoder().decode(Album.self, from: albumData)
      return album
    }
  }
}

extension HundredBestAlbum {
  static var mock: HundredBestAlbum {
    get throws {
      let albumData = try loadFixture(named: "hundred_best_album_mock")
      let album = try JSONDecoder().decode(HundredBestAlbum.self, from: albumData)
      return album
    }
  }
}

private func loadFixture(named name: String) throws -> Data {
  guard let url = Bundle.module.url(forResource: name, withExtension: "json") else {
    throw URLError(.fileDoesNotExist)
  }
  return try Data(contentsOf: url)
}
