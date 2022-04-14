//
//  File.swift
//  
//
//  Created by Rudrank Riyam on 09/04/22.
//

import MusicKit
import Foundation

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
extension MusicCatalogSearchable {
    static var identifier: ObjectIdentifier {
        ObjectIdentifier(Self.self)
    }
}


/// The suggestion kinds to include in the results.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
public enum SuggestionsKind: String, Codable {
    case terms
    case topResults
}

/// A request that your app uses to fetch search suggestions from the Apple Music catalog
/// using a search term.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public struct MusicCatalogSuggestionsRequest {

    /// A limit for the number of items to return
    /// in the catalog suggestions response.
    public var limit: Int?

    /// An offet for the request.
    public var offset: Int?

    /// The search term for the request.
    public let term: String

    /// The list of requested catalog searchable types.
    public var types: [MusicCatalogSearchable.Type]?

    private var kinds: [SuggestionsKind] = []

    /// Creates a catalog suggestions request for a specified search term.
    /// Set the `types` if the `kinds` is of the type `topResults`.
    public init(term: String, kinds: [SuggestionsKind], types: [MusicCatalogSearchable.Type]? = nil) {
        self.term = term
        self.types = types
        self.kinds = kinds
    }

    /// Fetches search suggestions of the requested catalog searchable types that match
    /// the search term of the request.
    public func response() async throws -> MusicCatalogSuggestionsResponse {
        let url = try await searchSuggestionsEndpointURL
        let request = MusicDataRequest(urlRequest: .init(url: url))
        let response = try await request.response()
        let items = try JSONDecoder().decode(Suggestions.self, from: response.data)
        return items.results
    }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
extension MusicCatalogSuggestionsRequest {
    private var searchSuggestionsEndpointURL: URL {
        get async throws {
            if self.kinds.contains(.topResults) && types == nil {
                throw MusadoraKitError.typeMissing
            }

            let storefront = try await MusicDataRequest.currentCountryCode
            let kinds = Set(kinds.map({ $0.rawValue })).joined(separator: ",")

            var queryItems: [URLQueryItem] = []
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.music.apple.com"
            components.path = "/v1/catalog/\(storefront)/search/suggestions"

            queryItems.append(URLQueryItem(name: "kinds", value: kinds))
            queryItems.append(URLQueryItem(name: "term", value: term))

            if let types = types {
                let searchTypes = setTypes(for: types)
                queryItems.append(URLQueryItem(name: "types", value: searchTypes))
            }

            if let limit = limit {
                queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
            }

            components.queryItems = queryItems

            guard let url = components.url else {
                throw URLError(.badURL)
            }

            return url
        }
    }

    private func setTypes(for types: [MusicCatalogSearchable.Type]) -> String {
        Set(types.map { $0.identifier }).compactMap {
            switch $0 {
                case Song.identifier:
                    return "songs"
                case Album.identifier:
                    return "albums"
                case Station.identifier:
                    return "stations"
                case MusicVideo.identifier:
                    return "music-videos"
                case Playlist.identifier:
                    return "playlists"
                case RecordLabel.identifier:
                    return "record-labels"
                case Artist.identifier:
                    return "artists"
                case RadioShow.identifier:
                    return "apple-curators"
                case Curator.identifier:
                    return "curators"
                default:
                    return nil
            }
        }.joined(separator: ",")
    }
}

/// An object that contains results for a catalog suggestions request.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public struct MusicCatalogSuggestionsResponse {

    /// A collection of search and display terms.
    public var terms: [TermSuggestion] = []

    /// A collection of different top results.
    public var topResults: [TopResultsSuggestion] = []
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
extension MusicCatalogSuggestionsResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case suggestions
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let suggestions = try container.decode([SuggestionKind].self, forKey: .suggestions)

        for suggestion in suggestions {
            switch suggestion {
                case .terms(let term):
                    terms.append(term)

                case .topResults(let topResult):
                    topResults.append(topResult)
            }
        }
    }

    public func encode(to encoder: Encoder) throws {}
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public struct TermSuggestion: Codable, Equatable, Hashable {
    public let kind: SuggestionsKind
    public let searchTerm: String
    public let displayTerm: String
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public struct TopResultsSuggestion: Codable, Equatable, Hashable {
    public let kind: SuggestionsKind
    public let content: SearchSuggestionItem
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public struct Suggestions: Codable {
    let results: MusicCatalogSuggestionsResponse
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public enum SearchSuggestionItem: Equatable, Hashable {
    case album(Album)
    case song(Song)
    case musicVideo(MusicVideo)
    case artist(Artist)
    case playlist(Playlist)
    case radioShow(RadioShow)
    case curator(Curator)
    case station(Station)
    case recordLabel(RecordLabel)
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
extension SearchSuggestionItem: Codable {
    enum CodingKeys: CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.decode(String.self, forKey: .type)

        switch type {
            case "albums":
                let album = try Album(from: decoder)
                self = .album(album)
            case "songs":
                let song = try Song(from: decoder)
                self = .song(song)
            case "stations":
                let station = try Station(from: decoder)
                self = .station(station)
            case "music-videos":
                let musicVideo = try MusicVideo(from: decoder)
                self = .musicVideo(musicVideo)
            case "playlists":
                let playlist = try Playlist(from: decoder)
                self = .playlist(playlist)
            case "record-labels":
                let recordLabel = try RecordLabel(from: decoder)
                self = .recordLabel(recordLabel)
            case "artists":
                let artist = try Artist(from: decoder)
                self = .artist(artist)
            case "apple-curators":
                let radioShow = try RadioShow(from: decoder)
                self = .radioShow(radioShow)
            case "curators":
                let curator = try Curator(from: decoder)
                self = .curator(curator)
            default:
                let decodingErrorContext = DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unexpected type \"\(type)\" encountered for SearchSuggestionItem."
                )
                throw DecodingError.typeMismatch(SearchSuggestionItem.self, decodingErrorContext)
        }
    }

    public func encode(to encoder: Encoder) throws {

    }
}

/// The suggestion kinds to include in the results.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public enum SuggestionKind: Codable {
    case terms(TermSuggestion)
    case topResults(TopResultsSuggestion)

    private enum CodingKeys: String, CodingKey {
        case kind
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(SuggestionsKind.self, forKey: .kind)

        switch kind {
            case .terms:
                let termSuggestion = try TermSuggestion(from: decoder)
                self = .terms(termSuggestion)
            case .topResults:
                let topResultsSuggestion = try TopResultsSuggestion(from: decoder)
                self = .topResults(topResultsSuggestion)
        }
    }

    public func encode(to encoder: Encoder) throws {}
}
