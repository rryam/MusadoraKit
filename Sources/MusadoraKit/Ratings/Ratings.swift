//
//  Ratings.swift
//  Ratings
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

public struct Ratings: Codable {
    let data: [Rating]
}

public struct Rating {
    public let value: RatingType
    public let href: String
    public let id: String
    public let type: String
}

extension Rating: Decodable {
    public struct Attributes: Codable {
        public let value: RatingType
    }

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

    }
}

public enum RatingType: Int, Codable {
    case loved = 1
    case disliked = -1
}
