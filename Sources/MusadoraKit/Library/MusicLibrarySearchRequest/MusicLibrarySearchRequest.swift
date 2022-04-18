//
//  MusicLibrarySearchRequest.swift
//  MusicLibrarySearchRequest
//
//  Created by Rudrank Riyam on 08/09/21.
//

import Foundation
import MusicKit

/// A request that your app uses to fetch items from the your library
/// using a search term.
public struct MusicLibrarySearchRequest {
    
    /// The search term for the request.
    public let term: String
    
    /// The list of requested library searchable types.
    public var types: [MusicLibrarySearchable.Type]
    
    /// A limit for the number of items to return
    /// in the library search response.
    public var limit: Int?
    
    /// An offet for the request.
    public var offset: Int?
    
    /// Creates a library search request for a specified search term
    /// and list of library searchable types.
    public init(term: String, types: [MusicLibrarySearchable.Type]) {
        self.term = term
        self.types = types
    }

    /// Fetches items of the requested library searchable types that match
    /// the search term of the request.
    public func response() async throws -> MusicLibrarySearchResponse {
        let url = try librarySearchEndpointURL
        let request = MusicDataRequest(urlRequest: .init(url: url))
        let response = try await request.response()
        let model = try JSONDecoder().decode(MusicLibrarySearchResponseResults.self, from: response.data)
        return model.results
    }
}

extension MusicLibrarySearchRequest {
    private var librarySearchEndpointURL: URL {
        get throws {
            var components = URLComponents()
            var queryItems: [URLQueryItem] = []

            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = "/v1/me/library/search"

            let termValue = term.replacingOccurrences(of: " ", with: "+")
            let termQuery = URLQueryItem(name: "term", value: termValue)
            queryItems.append(termQuery)

            let typesValue = MusicLibrarySearchType.getTypes(types)
            let typesQuery = URLQueryItem(name: "types", value: typesValue)
            queryItems.append(typesQuery)

            if let limit = limit {
                queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
            }

            if let offset = offset {
                queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
            }

            components.queryItems = queryItems

            guard let url = components.url else {
                throw URLError(.badURL)
            }
            return url
        }
    }
}
