//
//  MusicCatalogChartRequest.swift
//  MusicCatalogChartRequest
//
//  Created by Rudrank Riyam on 26/03/22.
//

import Foundation
import MusicKit

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
