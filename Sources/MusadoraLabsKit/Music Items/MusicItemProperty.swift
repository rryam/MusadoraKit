//
//  MusicItemProperty.swift
//  MusicItemProperty
//
//  Created by Rudrank Riyam on 22/07/22.
//

import Foundation

public struct MusicItemProperty<ItemType>: Codable where ItemType: MusicItemTypeable {
    public var type: ItemType
    public var code: String
    public var description: String
}

extension MusicItemProperty: Identifiable {
    public var id: ItemType {
        type
    }
}
