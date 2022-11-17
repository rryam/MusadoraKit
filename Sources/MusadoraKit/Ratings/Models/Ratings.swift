//
//  Rating.swift
//  Rating
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

public struct Rating {
  public let value: RatingType
  public let href: String
  public let id: String
  public let type: String
}

extension Rating: Identifiable {}

extension Rating: Equatable {}

extension Rating: Hashable {}

extension Rating: Decodable {
  enum CodingKeys: String, CodingKey {
    case attributes, href, id, type
  }

  enum AttributesKey: String, CodingKey {
    case value
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(String.self, forKey: .id)
    href = try container.decode(String.self, forKey: .href)
    type = try container.decode(String.self, forKey: .type)

    let attributesContainer = try container.nestedContainer(keyedBy: AttributesKey.self, forKey: .attributes)
    value = try attributesContainer.decode(RatingType.self, forKey: .value)
  }
}

extension Rating: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(href, forKey: .href)
    try container.encode(type, forKey: .type)

    var attributesContainer = container.nestedContainer(keyedBy: AttributesKey.self, forKey: .attributes)
    try attributesContainer.encode(value, forKey: .value)
  }
}
