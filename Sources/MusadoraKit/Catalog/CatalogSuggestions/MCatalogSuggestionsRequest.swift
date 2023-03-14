//
//  MCatalogSuggestionsRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation


/// A request that your app uses to fetch search suggestions from the Apple Music catalog
/// using a search term.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
struct MCatalogSuggestionsRequest {
  /// A limit for the number of items to return
  /// in the catalog suggestions response.
  var limit: Int?

  /// An offet for the request.
  var offset: Int?

  /// The search term for the request.
  let term: String

  /// The list of requested catalog searchable types.
  var types: [MusicCatalogSearchable.Type]?

  private var kinds: [SuggestionsKind] = []

  /// Creates a catalog suggestions request for a specified search term.
  /// Set the `types` if the `kinds` is of the type `topResults`.
  init(term: String, kinds: [SuggestionsKind], types: [MusicCatalogSearchable.Type]? = nil) {
    self.term = term
    self.types = types
    self.kinds = kinds
  }

  /// Fetches search suggestions of the requested catalog searchable types that match
  /// the search term of the request.
  func response() async throws -> MCatalogSuggestionsResponse {
    let url = try await searchSuggestionsEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(Suggestions.self, from: response.data)
    return items.results
  }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
extension MCatalogSuggestionsRequest {
  private var searchSuggestionsEndpointURL: URL {
    get async throws {
      if self.kinds.contains(.topResults), types == nil {
        throw MusadoraKitError.typeMissing
      }

      let storefront = try await MusicDataRequest.currentCountryCode
      let kinds = Set(kinds.map { $0.rawValue }).joined(separator: ",")

      var queryItems: [URLQueryItem] = []
      var components = AppleMusicURLComponents()
      components.path = "catalog/\(storefront)/search/suggestions"

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
