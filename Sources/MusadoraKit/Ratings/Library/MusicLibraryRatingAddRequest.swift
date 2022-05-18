//
//  MusicLibraryRatingAddRequest.swift
//  MusicLibraryRatingAddRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public struct MusicLibraryRatingAddRequest<MusicItemType> where MusicItemType: MusicItem, MusicItemType: Decodable {

    /// Creates a request to fetch items using a filter that matches
    /// a specific value.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterableLibraryRatingType, Value>, equalTo value: Value, rating: RatingType) where MusicItemType: FilterableLibraryRatingItem {
        self.rating = rating

        setType()

        if let id = value as? MusicItemID {
            self.id = id.rawValue
        }
    }

    public func response() async throws -> MusicRatingResponse {
        let url = try libraryAddRatingsEndpointURL

        let rating = AddRating(attributes: .init(value: rating))
        let data = try JSONEncoder().encode(rating)

        let request = MusicDataPutRequest(url: url, data: data)
        let response = try await request.response()
        let items = try JSONDecoder().decode(Ratings.self, from: response.data)
        return MusicRatingResponse(items: items.data)
    }

    private var type: LibraryRatingMusicItemType?
    private var id: String?
    private var rating: RatingType
}

extension MusicLibraryRatingAddRequest {
    private mutating func setType() {
        switch MusicItemType.self {
            case is Song.Type: type = .songs
            case is Album.Type: type = .albums
            case is MusicVideo.Type: type = .musicVideos
            case is Playlist.Type: type = .playlists
            default: type = nil
        }
    }

    internal var libraryAddRatingsEndpointURL: URL {
        get throws {
            guard let type = type else { throw URLError(.badURL) }

            var components = URLComponents()

            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = "/v1/me/ratings/"

            if let id = id {
                components.path += "\(type.rawValue)/\(id)"
            }

            guard let url = components.url else {
                throw URLError(.badURL)
            }
            return url
        }
    }
}
