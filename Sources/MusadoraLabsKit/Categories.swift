//
//  Categories.swift
//  Categories
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

public enum Categories: String {
    case albums
    case artists
    case songs
    case musicVideos

    case playlists
    case stations

    case search

    case ratings
    case genres
    case charts

    case recommendations
    case history

    case recordLabels
    case curators

    public var sectionName: [String] {
        [
            "Albums, Artists, Songs, and Videos",
            "Playlists and Stations",
            "Search",
            "Ratings, Genres, and Charts",
            "Activities, Curators, and Record Labels",
            "Recommendations and History",
            "Fetching Multiple Resource Types",
        ]
    }

    public var name: String {
        switch self {
            case .albums: return "Albums"
            case .artists: return "Artists"
            case .songs: return "Songs"
            case .musicVideos: return "Music Videos"
            case .playlists: return "Playlists"
            case .stations: return "Apple Music Stations"
            case .search: return "Search"
            case .ratings: return "Ratings"
            case .genres: return "Music Genres"
            case .charts: return "Charts"
            case .recordLabels: return "Record Labels"
            case .curators: return "Curators"
            case .recommendations: return "Recommendations"
            case .history: return "History"
        }
    }

    public var description: String {
        switch self {
            case .albums:
                return "Get an album’s name, artist, list of tracks, artwork, release date, and recording information, and add new albums to the user’s library."
            case .artists:
                return "Get information about an artist, including the content they created and references to them in playlists and radio stations."
            case .songs:
                return "Get information about a particular song, including the artist who created it and the album on which it appeared."
            case .musicVideos:
                return "Get information about a music video, including the artist who created it and the associated album, and add new videos to the user’s library."
            case .playlists:
                return "Get the contents of playlists, add new playlists to the user's library, and add tracks to an existing playlist."
            case .stations:
                return "Get information about streaming content offered by Apple Music."
            case .search:
                return "Search for albums, songs, artists, and other information in the user’s personal library or the Apple Music Catalog."
            case .ratings:
                return "Get and set ratings for albums, songs, playlists, music videos, and stations."
            case .genres:
                return "Get information about the genres of the user’s music or items in the Apple Music Catalog."
            case .charts:
                return "Get chart information that shows the popularity of albums, songs, and music videos."
            case .recommendations:
                return "Get music recommendations based on the user’s library and purchase history."
            case .history:
                return "Get historical information about the songs and stations the user played recently."
            case .recordLabels:
                return "Get information on record labels in the Apple Music Catalog."
            case .curators:
                return "Get information about the person who curated a playlist or station."
        }
    }
}

extension Categories: Identifiable {
    public var id: String {
        rawValue
    }
}

extension Categories: CaseIterable {}
