//
//  MChartResponse.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import MusicKit

/// An object that contains results for a catalog chart request.
public struct MChartResponse {
  /// An array of collection of songs.
  public let songs: Songs

  /// An array of collection of playlists.
  public let playlists: Playlists

  /// An array of collection of music videos.
  public let musicVideos: MusicVideos

  /// An array of collection of albums.
  public let albums: Albums

  public let cityCharts: Playlists

  public let dailyGlobalTopCharts: Playlists
}

extension MChartResponse: Decodable {
  enum CodingKeys: String, CodingKey {
    case songs, playlists, albums
    case musicVideos = "music-videos"
    case cityCharts
    case dailyGlobalTopCharts
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    songs = try container.decodeIfPresent([Songs].self, forKey: .songs)?.first ?? []
    playlists = try container.decodeIfPresent([Playlists].self, forKey: .playlists)?.first ?? []
    musicVideos = try container.decodeIfPresent([MusicVideos].self, forKey: .musicVideos)?.first ?? []
    albums = try container.decodeIfPresent([Albums].self, forKey: .albums)?.first ?? []
    cityCharts = try container.decodeIfPresent([Playlists].self, forKey: .cityCharts)?.first ?? []
    dailyGlobalTopCharts = try container.decodeIfPresent([Playlists].self, forKey: .dailyGlobalTopCharts)?.first ?? []
  }
}

extension MChartResponse: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(songs, forKey: .songs)
    try container.encode(playlists, forKey: .playlists)
    try container.encode(musicVideos, forKey: .musicVideos)
    try container.encode(albums, forKey: .albums)
    try container.encode(cityCharts, forKey: .cityCharts)
    try container.encode(dailyGlobalTopCharts, forKey: .dailyGlobalTopCharts)
  }
}

extension MChartResponse: Equatable, Hashable {}

// extension MusicCatalogChartResponse: CustomStringConvertible {
//    public var description: String {
//        var description: [String] = []
//        if !songs.isEmpty {
//            description.append("songs: \(flatten(songs))")
//        }
//
//        if !playlists.isEmpty {
//            description.append("playlists: \(flatten(playlists))")
//        }
//
//        if !albums.isEmpty {
//            description.append("albums: \(flatten(albums))")
//        }
//
//        if !musicVideos.isEmpty {
//            description.append("music videos: \(flatten(musicVideos))")
//        }
//
//        return "\(Self.self)(\n\(description.joined(separator: ", \n"))\n)"
//    }
//
//    private func flatten<Type>(_ type: [ChartItemCollection<Type>]) -> String where Type: MusicCatalogChart {
//        "\(type.compactMap { $0 })"
//    }
// }
