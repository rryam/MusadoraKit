//
//  MusicItemAttributeType.swift
//  MusicItemAttributeType
//
//  Created by Rudrank Riyam on 25/07/22.
//

import Foundation

public enum MusicItemAttributeType: String {
  case contentRating
  case editorialNotes
  case previewAsset
}

extension MusicItemAttributeType: Capitalizable {}

extension MusicItemAttributeType: CaseIterable {}

extension MusicItemAttributeType: SelfIdentifiable {}

