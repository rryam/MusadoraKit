//
//  CatalogGenre.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/08/21.
//

import MusicKit
import Foundation

public extension MCatalog {
  /// Fetch a genre from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the genre.
  /// - Returns: `Genre` matching the given identifier.
  static func genre(with id: MusicItemID) async throws -> Genre {
    let request = MusicCatalogResourceRequest<Genre>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let genre = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return genre
  }

  /// Fetch multiple genres from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the genres.
  /// - Returns: `Genres` matching the given identifiers.
  static func genres(with ids: [MusicItemID]) async throws -> Genres {
    let request = MusicCatalogResourceRequest<Genre>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return response.items
  }

  /// Fetch top genres from the Apple Music catalog.
  /// - Returns: Top `Genres`.
  static func topGenres() async throws -> Genres {
#if compiler(>=5.7)
    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
      let request = MusicCatalogResourceRequest<Genre>()
      let response = try await request.response()
      return response.items
    } else {
      return try await topGenresAPI()
    }
#else
    return try await topGenresAPI()
#endif
  }
}

extension MCatalog {
  static private func topGenresAPI() async throws -> Genres {
    let countryCode = try await MusicDataRequest.currentCountryCode
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(countryCode)/genres"

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()

    return try JSONDecoder().decode(Genres.self, from: response.data)
  }
}
