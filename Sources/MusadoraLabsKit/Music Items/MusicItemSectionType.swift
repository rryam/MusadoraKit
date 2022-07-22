//
//  MusicItemSectionType.swift
//  MusicItemSectionType
//
//  Created by Rudrank Riyam on 22/07/22.
//

import Foundation

public enum MusicItemSectionType: String, Codable {
    case primary
    case secondary
    case relationships
    case classical
}

extension MusicItemSectionType: Identifiable {
    public var id: Self {
        self
    }
}
