//
//  MusicHistoryRequest.swift
//  MusicHistoryRequest
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

public extension MusadoraKit {

    /// Fetch the recently played resources for the user.
    /// - Parameter limit: The number of objects returned.
    /// - Returns: Collection of `UserMusicItem` that may be albums, playlists or stations.
    static func recentlyPlayed(limit: Int? = nil) async throws -> UserMusicItems {
        var request = MusicHistoryRequest(for: .recentlyPlayed)
        request.limit = limit
        let response = try await request.response()
        return response.items
    }

    /// Fetch the resources in heavy rotation for the user.
    /// - Parameter limit: The number of objects returned.
    /// - Returns: Collection of `UserMusicItem` that may be albums, playlists or stations.
    static func heavyRotation(limit: Int? = nil) async throws -> UserMusicItems {
        var request = MusicHistoryRequest(for: .heavyRotation)
        request.limit = limit
        let response = try await request.response()
        return response.items
    }

    /// Fetch the recently added resources for the user.
    /// - Parameter limit: The number of objects returned.
    /// - Returns: Collection of `UserMusicItem` that may be albums, playlists or stations.
    static func recentlyAdded(limit: Int? = nil) async throws -> UserMusicItems {
        var request = MusicHistoryRequest(for: .recentlyAdded)
        request.limit = limit
        let response = try await request.response()
        return response.items
    }

    /// Fetch the recently played tracks for the user.
    /// - Parameter limit: The number of objects returned.
    /// - Returns: Collection of `Tracks`.
    static func recentlyPlayedTracks(limit: Int? = nil) async throws -> Tracks {
        var request = MusicHistoryRequest(for: .recentlyPlayedTracks)
        request.limit = limit
        let response = try await request.response()
        return response.tracks
    }

    /// Fetch the recently played stations for the user.
    /// - Parameter limit: The number of objects returned.
    /// - Returns: Collection of `Stations`.
    static func recentlyPlayedStations(limit: Int? = nil) async throws -> Stations {
        var request = MusicHistoryRequest(for: .recentlyPlayedStations)
        request.limit = limit
        let response = try await request.response()
        return response.stations
    }
}

/// A  request that your app uses to fetch historical information about
/// the songs and stations the user played recently.
public struct MusicHistoryRequest {
    /// A limit for the number of items to return
    /// in the history response.
    public var limit: Int?

    /// Endpoints to fetch historical information about the songs and stations the user played recently.
    /// Possible values: `heavyRotation`, `recentlyAdded` and `recentlyPlayed`.
    public var endpoint: MusicHistoryEndpoints

    /// Creates a request to fetch historical data based on the history endpoint.
    public init(for endpoint: MusicHistoryEndpoints) {
        self.endpoint = endpoint
    }

    /// Fetches historical information based on the user’s history for the given request.
    public func response() async throws -> MusicHistoryResponse {
        let url = try historyEndpointURL
        let request = MusicDataRequest(urlRequest: .init(url: url))
        let response = try await request.response()
        let items = try JSONDecoder().decode(UserMusicItems.self, from: response.data)
        return MusicHistoryResponse(items: items)
    }
}

extension MusicHistoryRequest {
    internal var historyEndpointURL: URL {
        get throws {
            var components = URLComponents()

            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = "/v1/me/"
            components.path += endpoint.path

            if let limit = limit {
                var maximumLimit: Int

                switch endpoint {
                    case .heavyRotation, .recentlyPlayed, .recentlyPlayedStations: maximumLimit = 10
                    case .recentlyAdded: maximumLimit = 25
                    case .recentlyPlayedTracks: maximumLimit = 30
                }

                guard limit <= maximumLimit else {
                    throw MusadoraKitError.historyOverLimit(limit: maximumLimit, overLimit: limit)
                }

                components.queryItems = [.init(name: "limit", value: "\(limit)")]
            }

            guard let url = components.url else {
                throw URLError(.badURL)
            }
            return url
        }
    }
}
