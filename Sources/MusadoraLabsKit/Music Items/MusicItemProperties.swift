//
//  MusicItemProperties.swift
//  MusicItemProperties
//
//  Created by Rudrank Riyam on 22/07/22.
//

import Foundation

public struct MusicItemProperties<ItemType>: Codable where ItemType: MusicItemTypeable {
    public var type: MusicItemSectionType
    public var title: String
    public var items: [MusicItemProperty<ItemType>]
}

extension MusicItemProperties: Identifiable {
    public var id: String {
        title
    }
}
