//
//  CatalogGenre.swift
//  CatalogGenre
//
//  Created by Rudrank Riyam on 17/08/21.
//

import Foundation
import MusicKit

/// A collection of genres.
public typealias Genres = MusicItemCollection<Genre>

public extension MusadoraKit {
  /// Fetch a genre from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the genre.
  ///   - properties: Additional relationships to fetch with the genre.
  /// - Returns: `Genre` matching the given identifier.
  static func catalogGenre(id: MusicItemID,
                           with properties: [PartialMusicAsyncProperty<Genre>] = []) async throws -> Genre
  {
    var request = MusicCatalogResourceRequest<Genre>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let genre = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return genre
  }

  /// Fetch multiple genres from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the genres.
  ///   - properties: Additional relationships to fetch with the genres.
  /// - Returns: `Genres` matching the given identifiers.
  static func catalogGenres(ids: [MusicItemID],
                            with properties: [PartialMusicAsyncProperty<Genre>] = []) async throws -> Genres
  {
    var request = MusicCatalogResourceRequest<Genre>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  static func catalogTopChartsGenres() async throws -> Genres {
    let countryCode = try await MusicDataRequest.currentCountryCode
    let genreURL = "https://api.music.apple.com/v1/catalog/\(countryCode)/genres"

    guard let url = URL(string: genreURL) else {
      throw URLError(.badURL)
    }

    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()

    return try JSONDecoder().decode(Genres.self, from: response.data)
  }
}
