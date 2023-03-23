//
//  StationGenre.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 12/03/23.
//

import Foundation

public struct StationGenre: Sendable {
  public let id: MusicItemID
  public let type: String
  public let name: String
}

extension StationGenre: Decodable {
  enum CodingKeys: String, CodingKey {
    case attributes, id, type
  }
  
  enum AttributesKey: String, CodingKey {
    case name
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(MusicItemID.self, forKey: .id)
    type = try container.decode(String.self, forKey: .type)
    
    let attributesContainer = try container.nestedContainer(keyedBy: AttributesKey.self, forKey: .attributes)
    name = try attributesContainer.decode(String.self, forKey: .name)
  }
}

extension StationGenre: MusicItem {}

extension StationGenre: Equatable, Hashable, Identifiable {
  public static func == (lhs: StationGenre, rhs: StationGenre) -> Bool {
    lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
