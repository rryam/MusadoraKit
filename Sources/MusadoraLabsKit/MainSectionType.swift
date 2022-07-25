//
//  MainSectionType.swift
//  MainSectionType
//
//  Created by Rudrank Riyam on 26/07/22.
//

import Foundation

public enum MainSectionType {
  case musicItems([MusicItemType])
  case musicItemAttributes([MusicItemAttributeType])
  case catalogSearch([CatalogSearchType])
}

extension MainSectionType: CustomStringConvertible {
  public var description: String {
    switch self {
      case .musicItems(_): return "Music Items"
      case .musicItemAttributes(_): return "Music Item Attributes"
      case .catalogSearch(_): return "Catalog Search"
    }
  }
}

extension MainSectionType: CaseIterable {
  public static var allCases: [MainSectionType] {
    [.musicItems(MusicItemType.allCases), .musicItemAttributes(MusicItemAttributeType.allCases), .catalogSearch(CatalogSearchType.allCases)]
  }
}

extension MainSectionType: SelfIdentifiable {}
