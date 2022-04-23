//
//  MusicCatalogResourcesType.swift
//  MusicCatalogResourcesType
//
//  Created by Rudrank Riyam on 23/04/22.
//

import MusicKit

/// A collection of music catalog resources types.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
typealias MusicCatalogResourcesTypes = MusicItemCollection<MusicCatalogResourcesType>

/// A generic music item to represent each of the catalog music items.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public enum MusicCatalogResourcesType {
    case station(Station)
    case genre(Genre)
    case song(Song)
    case recordLabel(RecordLabel)
    case playlist(Playlist)
    case artist(Artist)
    case album(Album)
    case curator(Curator)
    case radioShow(RadioShow)
    case musicVideo(MusicVideo)

    public enum Key: String, Codable {
        case stations
        case genres
        case songs
        case recordLabels = "record-labels"
        case playlists
        case artists
        case albums
        case curators
        case radioShows = "apple-curators"
        case musicVideos = "music-videos"

        public var type: String {
            "ids[\(self.rawValue)]".removingPercentEncoding!
        }
    }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
extension MusicCatalogResourcesType: MusicItem {
    public var id: MusicItemID {
        let id: MusicItemID

        switch self {
            case .station(let station): id = station.id
            case .genre(let genre): id = genre.id
            case .song(let song): id = song.id
            case .recordLabel(let recordLabel): id = recordLabel.id
            case .playlist(let playlist): id = playlist.id
            case .artist(let artist): id = artist.id
            case .album(let album): id = album.id
            case .curator(let curator): id = curator.id
            case .radioShow(let radioShow): id = radioShow.id
            case .musicVideo(let musicVideo): id = musicVideo.id
        }

        return id
    }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
extension MusicCatalogResourcesType: Decodable {
    enum CodingKeys: CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.decode(MusicCatalogResourcesType.Key.self, forKey: .type)

        switch type {
            case .songs:
                let song = try Song(from: decoder)
                self = .song(song)
            case .playlists:
                let playlist = try Playlist(from: decoder)
                self = .playlist(playlist)
            case .stations:
                let station = try Station(from: decoder)
                self = .station(station)
            case .musicVideos:
                let musicVideo = try MusicVideo(from: decoder)
                self = .musicVideo(musicVideo)
            case .radioShows:
                let radioShow = try RadioShow(from: decoder)
                self = .radioShow(radioShow)
            case .curators:
                let curator = try Curator(from: decoder)
                self = .curator(curator)
            case .genres:
                let genre = try Genre(from: decoder)
                self = .genre(genre)
            case .albums:
                let album = try Album(from: decoder)
                self = .album(album)
            case .recordLabels:
                let recordLabel = try RecordLabel(from: decoder)
                self = .recordLabel(recordLabel)
            case .artists:
                let artist = try Artist(from: decoder)
                self = .artist(artist)
        }
    }
}
