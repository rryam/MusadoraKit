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
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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
        var queryItems: [URLQueryItem] = []
        
        let termValue = term.replacingOccurrences(of: " ", with: "+")
        let termQuery = URLQueryItem(name: "term", value: termValue)
        queryItems.append(termQuery)
        
        let typesValue = MusicLibrarySearchType.getTypes(types)
        let typesQuery = URLQueryItem(name: "types", value: typesValue)
        queryItems.append(typesQuery)
        
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: String(describing: limit)))
        }
        
        if let offset = offset {
            queryItems.append(URLQueryItem(name: "offset", value: String(describing: offset)))
        }

        let storeFront = try await MusicDataRequest.currentCountryCode
        let model: MusicLibrarySearchResponseResults = try await MusadoraKit.decode(endpoint: .librarySearch(with: queryItems, storeFront: storeFront))
        return model.results
    }
}
