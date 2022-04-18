//
//  CatalogChart.swift
//  CatalogChart
//
//  Created by Rudrank Riyam on 26/03/22.
//

import Foundation
import MusicKit

public protocol MusicCatalogChart {}

extension MusicCatalogChart {
    static var objectIdentifier: ObjectIdentifier {
        ObjectIdentifier(Self.self)
    }
}

extension Song: MusicCatalogChart {}

extension Playlist: MusicCatalogChart {}

extension MusicVideo: MusicCatalogChart {}

extension Album: MusicCatalogChart {}

struct Charts: Codable {
    let results: MusicCatalogChartResponse
}

/// A collection of chart items.
public struct ChartItemCollection<MusicItemType> where MusicItemType: MusicItem {

    /// The unique name of the chart to use when fetching a specific chart.
    public let chart: String

    /// The localized display name for the chart.
    public let name: String

    /// A relative cursor to fetch the next paginated results for the chart if more exist.
    public let next: String?

    /// The popularity-ordered music item type for the chart.
    public let items: [MusicItemType]

    enum CodingKeys: String, CodingKey {
        case chart, name
        case next
        case items = "data"
    }
}

extension ChartItemCollection {

    /// A Boolean value that indicates whether the collection has information
    /// that allows it to fetch a subsequent batch of items.
    public var hasNextBatch: Bool {
        next == nil
    }
}

extension ChartItemCollection where MusicItemType: MusicCatalogChart {}

extension ChartItemCollection: Decodable where MusicItemType: Decodable {}

extension ChartItemCollection: Encodable where MusicItemType: Encodable {}

extension ChartItemCollection: Equatable, Hashable {
    public static func == (lhs: ChartItemCollection<MusicItemType>, rhs: ChartItemCollection<MusicItemType>) -> Bool {
        lhs.chart == rhs.chart
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(chart)
    }
}

/// A  chart request that your app uses to fetch charts from the Apple Music catalog
/// using the types of charts and for the genre identifier.
public struct MusicCatalogChartRequest {
    /// The identifier for the genre to use in the chart results.
    public var genre: MusicItemID?

    /// A limit for the number of items to return
    /// in the catalog chart response.
    public var limit: Int?

    private var types: String

    /// Creates a request to fetch charts using the list of the
    /// types of charts to include in the results.
    public init(for types: [MusicCatalogChart.Type]) {
        self.types = Set(types.map({ $0.objectIdentifier })).compactMap {
            switch $0 {
                case Song.objectIdentifier:
                    return "songs"
                case Album.objectIdentifier:
                    return "albums"
                case MusicVideo.objectIdentifier:
                    return "music-videos"
                case Playlist.objectIdentifier:
                    return "playlists"
                default:
                    return nil
            }
        }.joined(separator: ",")
    }

    /// Fetches charts of the requested catalog chart types that match
    /// the genre identifier of the request.
    public func response() async throws -> MusicCatalogChartResponse {
        let url = try await createURL()

        let request = MusicDataRequest(urlRequest: .init(url: url))
        let response = try await request.response()

        let charts = try JSONDecoder().decode(Charts.self, from: response.data)

        return charts.results
    }
}

extension MusicCatalogChartRequest {
    private func createURL() async throws -> URL {
        let storefront = try await MusicDataRequest.currentCountryCode

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.music.apple.com"
        components.path = "/v1/catalog/\(storefront)/charts"

        var queryItems: [URLQueryItem] = []

        queryItems.append(URLQueryItem(name: "types", value: types))

        if let genre = genre {
            queryItems.append(URLQueryItem(name: "genre", value: genre.rawValue))
        }

        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }

        components.queryItems = queryItems

        guard let url = components.url else { throw URLError(.badURL) }
        return url
    }
}

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

