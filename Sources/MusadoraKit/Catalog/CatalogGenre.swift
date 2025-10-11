//
//  CatalogGenre.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/08/21.
//

import Foundation

public extension MCatalog {
  /// Fetch a genre from the Apple Music catalog by using its identifier.
  /// 
  /// - Parameters:
  ///   - id: The unique identifier for the genre.
  /// - Returns: `Genre` matching the given identifier.
  static func genre(id: MusicItemID) async throws -> Genre {
    let request = MusicCatalogResourceRequest<Genre>(matching: \.id, equalTo: id)
    let response = try await request.response()
    
    guard let genre = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return genre
  }
  
  /// Fetch multiple genres from the Apple Music catalog by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the genres.
  /// - Returns: `Genres` matching the given identifiers.
  static func genres(ids: [MusicItemID]) async throws -> Genres {
    let request = MusicCatalogResourceRequest<Genre>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return try await response.items.collectingAll()
  }
  
  /// Fetch top genres from the Apple Music catalog.
  /// - Returns: Top `Genres`.
  static func topGenres() async throws -> Genres {
    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      let request = MusicCatalogResourceRequest<Genre>()
      let response = try await request.response()
      return try await response.items.collectingAll()
    } else {
      let storefront = try await MusicDataRequest.currentCountryCode
      return try await topGenres(for: storefront)
    }
  }

  /// Fetch top genres from the Apple Music catalog for a particular storefront.
  ///
  /// - Parameters:
  ///   - storefront: The identifier of the storefront for which to retrieve the top genres.
  /// - Returns: Top `Genres` for the particular storefront.
  static func topGenres(for storefront: String) async throws -> Genres {
    let url = try topGenresURL(storefront: storefront)
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()

    return try JSONDecoder().decode(Genres.self, from: response.data)
  }
}

extension MCatalog {
  internal static func topGenresURL(storefront: String) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(storefront)/genres"

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}

public extension MCatalog {
  /// Fetch all genres from the Apple Music catalog across all Apple Music storefronts.
  ///
  /// - Returns: Unique `Genres` from all storefronts.
  static func allGenres() async throws -> Genres {
    try await withThrowingTaskGroup(of: Genres.self) { group in
      let storefronts = try await MCatalog.storefronts().map { $0.id }
      var allGenres: Set<Genre> = []

      for storefront in storefronts {
        group.addTask {
          return try await topGenres(for: storefront)
        }
      }

      for try await genres in group {
        allGenres = mergeGenres(allGenres, with: genres)
      }

      return MusicItemCollection(allGenres)
    }
  }

  private static func mergeGenres(_ existingGenres: Set<Genre>, with newGenres: Genres) -> Set<Genre> {
    var mergedGenres = existingGenres

    for genre in newGenres {
      if !mergedGenres.contains(where: { $0.id == genre.id && $0.name == $0.name }) {
        mergedGenres.insert(genre)
      }
    }

    return mergedGenres
  }
}

public extension MCatalog {
  /// Fetches the list of station genres available in the current country's storefront from Apple Music catalog.
  ///
  /// - Returns: `StationGenres` representing the list of station genres available in the current country's storefront.
  static func stationGenres() async throws -> StationGenres {
    let storefront = try await MusicDataRequest.currentCountryCode
    let url = try stationGenresURL(storefront: storefront)

    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()

    let stationsGenres = try JSONDecoder().decode(StationGenres.self, from: response.data)

    return stationsGenres
  }

  /// Fetches the list of station genres available in the current country's storefront from Apple Music catalog.
  ///
  /// - Returns: `StationGenres` representing the list of station genres available in the current country's storefront.
  static func stationGenres(for storefront: MStorefront) async throws -> StationGenres {
    let url = try stationGenresURL(storefront: storefront.id)
    let request = MusicDataRequest(urlRequest: URLRequest(url: url))
    let response = try await request.response()

    let stationsGenres = try JSONDecoder().decode(StationGenres.self, from: response.data)

    return stationsGenres
  }

  internal static func stationGenresURL(storefront: String) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(storefront)/station-genres"

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
