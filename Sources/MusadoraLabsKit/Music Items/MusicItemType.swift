//
//  MusicItemType.swift
//  MusicItemType
//
//  Created by Rudrank Riyam on 25/07/22.
//

import Foundation

public enum MusicItemType: String {
  case album
  case artist
  case curator
  case genre
  case musicVideo
  case playlist
  case radioShow
  case recordLabel
  case song
  case station
  case track
}

extension MusicItemType: Capitalizable {}

extension MusicItemType: CaseIterable {}

extension MusicItemType: SelfIdentifiable {}
