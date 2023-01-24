//
//  LibraryPlaylistFolder.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 26/12/22.
//

import Foundation

public struct LibraryPlaylistFolder: Codable, Sendable {
  public let id: String
  public let type: String
  public let attributes: Attributes?
  public let relationships: Relationships?

  public struct Attributes: Codable, Sendable {
    public let dateAdded: Date
    public let name: String
  }

  public struct Relationships: Codable, Sendable {
    
  }
}
