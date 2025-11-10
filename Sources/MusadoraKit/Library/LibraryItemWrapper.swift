//
//  LibraryItemWrapper.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/11/25.
//

import Foundation

/// A lightweight wrapper to decode only the `inFavorites` property from library items.
internal struct LibraryItemWrapper: Codable {
  let id: String
  let attributes: Attributes

  struct Attributes: Codable {
    let inFavorites: Bool?
  }
}

/// A collection response wrapper for library items.
internal struct LibraryItemsResponse: Codable {
  let data: [LibraryItemWrapper]
}
