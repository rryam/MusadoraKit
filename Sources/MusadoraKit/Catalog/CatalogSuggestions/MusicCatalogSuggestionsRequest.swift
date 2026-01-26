//
//  MusicCatalogSuggestionsRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation

/// A request that your app uses to fetch search suggestions from the Apple Music catalog.
///
/// This structure enables fetching intelligent search suggestions as users type, helping them
/// discover content more efficiently.
///
/// Example usage:
/// ```swift
/// let request = MusicCatalogSuggestionsRequest(
///     term: "taylor",
///     kinds: [.terms, .topResults],
///     types: [Song.self, Artist.self]
/// )
///
/// do {
///     let suggestions = try await request.response()
///     print(suggestions.terms)
///     print(suggestions.topResults)
/// } catch {
///     print("Failed to fetch suggestions: \(error)")
/// }
/// ```
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
struct MusicCatalogSuggestionsRequest {
  /// A limit for the number of suggestions to return.
  var limit: Int?

  /// An offset for paginating through suggestions.
  var offset: Int?

  /// The search term to get suggestions for.
  let term: String

  /// The types of catalog items to include in the suggestions.
  var types: [MusicCatalogSearchable.Type]?

  /// The kinds of suggestions to fetch (terms, topResults).
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
  func response() async throws -> MusicCatalogSuggestionsResponse {
    let url = try await searchSuggestionsEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(Suggestions.self, from: response.data)
    return items.results
  }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogSuggestionsRequest {
  internal var searchSuggestionsEndpointURL: URL {
    get async throws {
      if self.kinds.contains(.topResults), types == nil {
        throw MusadoraKitError.typeMissing
      }

      let storefront = try await MusicDataRequest.currentCountryCode
      return try endpointURL(storefront: storefront)
    }
  }

  internal func endpointURL(storefront: String) throws -> URL {
    let kindsValue = Set(kinds.map { $0.rawValue })
    guard !kindsValue.isEmpty else {
      throw MusadoraKitError.typeMissing
    }

    var queryItems: [URLQueryItem] = []
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(storefront)/search/suggestions"

    let kindsQuery = kindsValue.sorted().joined(separator: ",")
    queryItems.append(URLQueryItem(name: "kinds", value: kindsQuery))
    queryItems.append(URLQueryItem(name: "term", value: term))

    if let types = types {
      if let searchTypes = setTypes(for: types) {
        queryItems.append(URLQueryItem(name: "types", value: searchTypes))
      } else if self.kinds.contains(.topResults) {
        throw MusadoraKitError.typeMissing
      }
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

  private func setTypes(for types: [MusicCatalogSearchable.Type]) -> String? {
    let joined = Set(types.map { $0.identifier }).compactMap {
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

    return joined.isEmpty ? nil : joined
  }
}
