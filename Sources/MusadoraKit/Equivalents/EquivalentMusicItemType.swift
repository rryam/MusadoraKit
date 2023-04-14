//
//  EquivalentMusicItemType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation
import MusicKit
/// An enum representing the different types of equivalent music items.
enum EquivalentMusicItemType: String, Codable {
  case songs
  case albums
  case musicVideos = "music-videos"
}

extension EquivalentMusicItemType {

  /// Returns the equivalent music item type for the given type.
  ///
  /// - Parameter item: A type that conforms to `EquivalentRequestable`.
  ///
  /// - Throws: An error if the item type is not recognized.
  ///
  /// - Returns: The equivalent music item type for the given type.
  static func path(for item: EquivalentRequestable.Type) throws -> Self {
    let path: EquivalentMusicItemType

    switch item {
      case is Song.Type: path = .songs
      case is Album.Type: path = .albums
      case is MusicVideo.Type: path = .musicVideos
      default: throw NSError(domain: "Wrong equivalent music item type.", code: 0)
    }
    return path
  }
}
