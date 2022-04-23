//
//  MusicCatalogChartResponse.swift
//  MusicCatalogChartResponse
//
//  Created by Rudrank Riyam on 23/04/22.
//

import MusicKit

/// An object that contains results for a catalog chart request.
public struct MusicCatalogChartResponse {
    /// An array of collection of songs.
    public let songs: [ChartItemCollection<Song>]

    /// An array of collection of playlists.
    public let playlists: [ChartItemCollection<Playlist>]

    /// An array of collection of music videos.
    public let musicVideos: [ChartItemCollection<MusicVideo>]

    /// An array of collection of albums.
    public let albums: [ChartItemCollection<Album>]
}

extension MusicCatalogChartResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case songs, playlists, albums
        case musicVideos = "music-videos"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        songs = try container.decodeIfPresent([ChartItemCollection<Song>].self, forKey: .songs) ?? []
        playlists = try container.decodeIfPresent([ChartItemCollection<Playlist>].self, forKey: .playlists) ?? []
        musicVideos = try container.decodeIfPresent([ChartItemCollection<MusicVideo>].self, forKey: .musicVideos) ?? []
        albums = try container.decodeIfPresent([ChartItemCollection<Album>].self, forKey: .albums) ?? []
    }
}

extension MusicCatalogChartResponse: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(songs, forKey: .songs)
        try container.encode(playlists, forKey: .playlists)
        try container.encode(musicVideos, forKey: .musicVideos)
        try container.encode(albums, forKey: .albums)
    }
}

extension MusicCatalogChartResponse: Equatable, Hashable {}

extension MusicCatalogChartResponse: CustomStringConvertible {
    public var description: String {
        var description: [String] = []
        if !songs.isEmpty {
            description.append("songs: \(flatten(songs))")
        }

        if !playlists.isEmpty {
            description.append("playlists: \(flatten(playlists))")
        }

        if !albums.isEmpty {
            description.append("albums: \(flatten(albums))")
        }

        if !musicVideos.isEmpty {
            description.append("music videos: \(flatten(musicVideos))")
        }

        return "\(Self.self)(\n\(description.joined(separator: ", \n"))\n)"
    }

    private func flatten<Type>(_ type: [ChartItemCollection<Type>]) -> String where Type: MusicCatalogChart {
        "\(type.compactMap { $0 })"
    }
}

