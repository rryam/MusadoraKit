//
//  SearchSuggestionItem.swift
//  SearchSuggestionItem
//
//  Created by Rudrank Riyam on 23/04/22.
//

import MusicKit

/// The top search suggestion types.
/// Possible types: Albums, RadioShows, Artists, Curators, MusicVideos, Playlists, RecordLabels, Songs, Stations.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public enum SearchSuggestionItem: Equatable, Hashable {
    case album(Album)
    case song(Song)
    case musicVideo(MusicVideo)
    case artist(Artist)
    case playlist(Playlist)
    case radioShow(RadioShow)
    case curator(Curator)
    case station(Station)
    case recordLabel(RecordLabel)
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
extension SearchSuggestionItem: Codable {
    enum CodingKeys: CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.decode(String.self, forKey: .type)

        switch type {
            case "albums":
                let album = try Album(from: decoder)
                self = .album(album)
            case "songs":
                let song = try Song(from: decoder)
                self = .song(song)
            case "stations":
                let station = try Station(from: decoder)
                self = .station(station)
            case "music-videos":
                let musicVideo = try MusicVideo(from: decoder)
                self = .musicVideo(musicVideo)
            case "playlists":
                let playlist = try Playlist(from: decoder)
                self = .playlist(playlist)
            case "record-labels":
                let recordLabel = try RecordLabel(from: decoder)
                self = .recordLabel(recordLabel)
            case "artists":
                let artist = try Artist(from: decoder)
                self = .artist(artist)
            case "apple-curators":
                let radioShow = try RadioShow(from: decoder)
                self = .radioShow(radioShow)
            case "curators":
                let curator = try Curator(from: decoder)
                self = .curator(curator)
            default:
                let decodingErrorContext = DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unexpected type \"\(type)\" encountered for SearchSuggestionItem."
                )
                throw DecodingError.typeMismatch(SearchSuggestionItem.self, decodingErrorContext)
        }
    }

    public func encode(to encoder: Encoder) throws {

    }
}
