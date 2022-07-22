//
//  MusicItemStructure.swift
//  MusicItemStructure
//
//  Created by Rudrank Riyam on 22/07/22.
//

import Foundation

public protocol SelfIdentifiable: Hashable, Identifiable, Codable {}

extension SelfIdentifiable {
    public var id: Self {
        self
    }
}

public typealias MusicItemTypeable = SelfIdentifiable & MusicItemTypeFilter

public struct MusicItemStructure<ItemType>: Codable where ItemType: MusicItemTypeable {
    public var name: String
    public var description: String
    public var declaration: String
    public var properties: [MusicItemProperties<ItemType>]
}
