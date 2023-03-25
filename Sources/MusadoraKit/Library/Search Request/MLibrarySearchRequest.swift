//
//  MLibrarySearchRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

import Foundation

/// A request that your app uses to fetch items from the your library
/// using a search term.
struct MLibrarySearchRequest: Equatable, Hashable, Sendable {
  /// The search term for the request.
  let term: String

  /// The list of requested library searchable types.
  var types: [MLibrarySearchable.Type]

  /// A limit for the number of items to return
  /// in the library search response.
  var limit: Int?

  /// An offet for the request.
  var offset: Int?

  /// Creates a library search request for a specified search term
  /// and list of library searchable types.
  init(term: String, types: [MLibrarySearchable.Type]) {
    self.term = term
    self.types = types
  }

  /// Fetches items of the requested library searchable types that match
  /// the search term of the request.
  func response() async throws -> MLibrarySearchResponse {
    let url = try librarySearchEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let model = try JSONDecoder().decode(MLibrarySearchResponseResults.self, from: response.data)
    return model.results
  }

  static func == (a: MLibrarySearchRequest, b: MLibrarySearchRequest) -> Bool {
    a.self.term == b.self.term
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.hashValue)
  }
}

extension MLibrarySearchRequest {
  internal var librarySearchEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []
      components.path = "me/library/search"

      let termValue = term.replacingOccurrences(of: " ", with: "+").lowercased()
      let termQuery = URLQueryItem(name: "term", value: termValue)
      queryItems.append(termQuery)

      let typesValue = MLibrarySearchType.getTypes(types)
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
