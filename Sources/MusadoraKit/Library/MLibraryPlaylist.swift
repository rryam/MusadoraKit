//
//  MLibraryPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 06/10/22.
//

import Foundation


public struct MLibraryPlaylist: Codable, MusicItem {
  public let id: MusicItemID
  public let attributes: Attributes

  public struct Attributes: Codable, Sendable {
    public let canEdit: Bool
    public let name: String
    public let isPublic: Bool
    public let hasCatalog: Bool
    public let playParams: PlayParameters
    public let description: Description?
    public let artwork: Artwork?
  }

  public struct Description: Codable, Sendable {
    public let standard: String
  }

  public struct PlayParameters: Codable, Sendable {
    public let id: MusicItemID
    public let isLibrary: Bool
    public let globalID: MusicItemID?

    enum CodingKeys: String, CodingKey {
      case id, isLibrary
      case globalID = "globalId"
    }
  }

  public var globalID: String? {
    attributes.playParams.globalID?.rawValue
  }
}
