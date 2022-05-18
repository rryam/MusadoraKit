//
//  MusicCatalogRatingRequest.swift
//  MusicCatalogRatingRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import MusicKit
import Foundation

/// A request that your app uses to fetch and set
/// ratings for albums, songs, playlists, music videos, and stations
/// for content in the Apple Music catalog.
public struct MusicCatalogRatingRequest<MusicItemType> where MusicItemType: MusicItem, MusicItemType: Decodable {

    /// Creates a request to fetch items using a filter that matches
    /// a specific value.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterableCatalogRatingType, Value>, equalTo value: Value) where MusicItemType: FilterableCatalogRatingItem {

        setType()

        if let id = value as? MusicItemID {
            self.ids = [id.rawValue]
        }
    }

    /// Creates a request to fetch items using a filter that matches
    /// any value from an array of possible values.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterableCatalogRatingType, Value>, memberOf values: [Value]) where MusicItemType: FilterableCatalogRatingItem {

        setType()

        if let ids = values as? [MusicItemID] {
            self.ids = ids.map { $0.rawValue }
        }
    }

    public func response() async throws -> MusicRatingResponse {
        let url = try catalogRatingsEndpointURL
        let request = MusicDataRequest(urlRequest: .init(url: url))
        let response = try await request.response()
        let items = try JSONDecoder().decode(Ratings.self, from: response.data)
        return MusicRatingResponse(items: items.data)
    }

    private var type: CatalogRatingMusicItemType?
    private var ids: [String]?
}


extension MusicCatalogRatingRequest {
    private mutating func setType() {
        switch MusicItemType.self {
            case is Song.Type: type = .songs
            case is Album.Type: type = .albums
            case is Station.Type: type = .stations
            case is MusicVideo.Type: type = .musicVideos
            case is Playlist.Type: type = .playlists
            default: type = nil
        }
    }

    internal var catalogRatingsEndpointURL: URL {
        get throws {
            guard let type = type else { throw URLError(.badURL) }

            var components = URLComponents()
            var queryItems: [URLQueryItem]?

            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = "/v1/me/ratings/"
            components.path += type.rawValue

            if let ids = ids {
                queryItems = [URLQueryItem(name: "ids", value: ids.joined(separator: ","))]
            }

            components.queryItems = queryItems

            guard let url = components.url else {
                throw URLError(.badURL)
            }
            return url
        }
    }
}

