//
//  StationPropertyType.swift
//  StationPropertyType
//
//  Created by Rudrank Riyam on 23/07/22.
//

import Foundation

public typealias StationStructure = MusicItemStructure<StationPropertyType>

public enum StationPropertyType: String, SelfIdentifiable {
    case id
    case name
    case url
    case artwork
    case contentRating
    case duration
    case editorialNotes
    case playParameters
    case stationProviderName
    case episodeNumber
    case isLive
}
