//
//  HundredBestAlbum.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 19/05/24.
//

import Foundation

public struct HundredBestAlbum: Identifiable, MusicItem {
  public let id: MusicItemID
  public let name: String
  public let position: String
  public let title: String
  public let artwork: Artwork
  public let url: URL
  public let artistName: String
  public let sections: [Section]
  
  enum CodingKeys: String, CodingKey {
    case adamid
    case name
    case position
    case title
    case artwork
    case url
    case artistName
    case sections
  }
  
  public struct Section: Codable, Sendable {
    public let sectionName: String
    public let text: String?
    public let key: String?
    public let artwork: URL?
    public let altText: String?
    public let imageAltKey: String?
    public let imageAlt: String?
    public let attribution: String?
    public let pullQuoteAttrKey: String?
    public let pullQuoteAttr: String?
  }
}

extension HundredBestAlbum: Codable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id.rawValue, forKey: .adamid)
    try container.encode(name, forKey: .name)
    try container.encode(position, forKey: .position)
    try container.encode(title, forKey: .title)
    try container.encode(artwork, forKey: .artwork)
    try container.encode(url, forKey: .url)
    try container.encode(artistName, forKey: .artistName)
    try container.encode(sections, forKey: .sections)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let adamid = try container.decode(String.self, forKey: .adamid)
    id = MusicItemID(rawValue: adamid)
    name = try container.decode(String.self, forKey: .name)
    position = try container.decode(String.self, forKey: .position)
    title = try container.decode(String.self, forKey: .title)
    artwork = try container.decode(Artwork.self, forKey: .artwork)
    url = try container.decode(URL.self, forKey: .url)
    artistName = try container.decode(String.self, forKey: .artistName)
    sections = try container.decode([Section].self, forKey: .sections)
  }
}
