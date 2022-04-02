//
//  MusicLibraryResourceRequest.swift
//  MusicLibraryResourceRequest
//
//  Created by Rudrank Riyam on 02/04/22.
//

import MusicKit
import Foundation

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
fileprivate enum LibraryMusicItemType: String {
    case songs
    case playlists
    case albums
    case artists
    case musicVideos = "music-videos"
}

/// A request that your app uses to fetch items from the user's library
/// using a filter.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct MusicLibraryResourceRequest<MusicItemType> where MusicItemType: MusicItem, MusicItemType: Decodable {

    /// A limit for the number of items to return
    /// in the catalog resource response.
    public var limit: Int?

    private var type: LibraryMusicItemType?
    private var id: String?
    private var ids: [String]?

    /// Creates a request to fetch items using a filter that matches
    /// a specific value.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterLibraryType, Value>, equalTo value: Value) where MusicItemType: FilterableLibraryItem {
        getType()

        if let id = value as? MusicItemID {
            self.id = id.rawValue
        }
    }

    /// Creates a request to fetch items using a filter that matches
    /// any value from an array of possible values.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterLibraryType, Value>, memberOf values: [Value]) where MusicItemType: FilterableLibraryItem {
        getType()

        if let ids = values as? [MusicItemID] {
            self.ids = ids.map { $0.rawValue }
        }
    }

    /// Fetches items from the user's library that match a specific filter.
    public func response() async throws -> MusicLibraryResourceResponse<MusicItemType> {
        let url = try createURL()

        let request = MusicDataRequest(urlRequest: .init(url: url))
        let response = try await request.response()

        let items = try JSONDecoder().decode(MusicItemCollection<MusicItemType>.self, from: response.data)

        return MusicLibraryResourceResponse(items: items)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension MusicLibraryResourceRequest {
    private mutating func getType() {
        switch MusicItemType.self {
            case is Song.Type: type = .songs
            case is Album.Type: type = .albums
            case is Artist.Type: type = .artists
            case is MusicVideo.Type: type = .musicVideos
            case is Playlist.Type: type = .playlists
            default: type = nil
        }
    }

    private func createURL() throws -> URL {
        guard let type = type else { throw URLError(.badURL) }

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.music.apple.com"

        if let id = id {
            components.path = "/v1/me/library/\(type.rawValue)/\(id)"
        } else if let ids = ids {
            components.path = "/v1/me/library/\(type.rawValue)"

            var queryItems: [URLQueryItem] = []

            queryItems.append(URLQueryItem(name: "ids", value: ids.joined(separator: ",")))
            components.queryItems = queryItems
        } else {
            throw URLError(.badURL)
        }

        print(components.url)

        guard let url = components.url else { throw URLError(.badURL) }
        return url
    }
}