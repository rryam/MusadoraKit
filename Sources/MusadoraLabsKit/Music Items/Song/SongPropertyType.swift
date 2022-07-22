//
//  SongPropertyType.swift
//  SongPropertyType
//
//  Created by Rudrank Riyam on 22/07/22.
//

import Foundation

public typealias SongStructure = MusicItemStructure<SongPropertyType>

public enum SongPropertyType: String, Codable {
    // primary
    case id
    case title
    case url
    case trackNumber
    case albumTitle
    case artistName
    case artistURL
    case artwork
    case contentRating
    case duration
    case editorialNotes
    case playParameters

    // secondary
    case composerName
    case releaseDate
    case isrc
    case hasLyrics
    case discNumber
    case genreNames
    case previewAssets
    case audioVariants
    case isAppleDigitalMaster
    case lastPlayedDate
    case libraryAddedDate
    case playCount

    // relationships
    case albums
    case artists
    case composers
    case genres
    case musicVideos
    case station

    // classical
    case attribution
    case movementCount
    case movementName
    case movementNumber
    case workName
}

extension SongPropertyType: Identifiable {
    public var id: Self {
        self
    }
}
