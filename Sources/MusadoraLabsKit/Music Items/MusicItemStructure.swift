//
//  MusicItemStructure.swift
//  MusicItemStructure
//
//  Created by Rudrank Riyam on 22/07/22.
//

import Foundation

public typealias MusicItemTypeable = Codable & Identifiable & MusicItemTypeFilter & Hashable

public struct MusicItemStructure<ItemType>: Codable where ItemType: MusicItemTypeable {
    public var name: String
    public var description: String
    public var properties: [MusicItemProperties<ItemType>]
}
