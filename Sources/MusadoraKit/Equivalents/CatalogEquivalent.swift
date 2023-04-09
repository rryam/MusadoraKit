//
//  CatalogEquivalent.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation

public extension EquivalentRequestable {

  /// Fetches the equivalent music item for the given storefront.
  ///
  /// Example usage:
  ///
  ///     let album = try await Album(id: "123").equivalent(for: "us")
  ///     let song = try await Song(id: "456").equivalent(for: "uk")
  ///     let musicVideo = try await MusicVideo(id: "789").equivalent(for: "fr")
  ///
  /// - Parameters:
  /// - targetStorefront: A string representing the storefront for which the equivalent music item should be fetched.
  ///
  /// - Returns: A equivalent music item for the given storefront.
  func equivalent(for targetStorefront: String) async throws -> Self {
    let path = try EquivalentMusicItemType.path(for: Self.self)

    let url = try equivalentURL(storefront: targetStorefront, path: path)
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(MusicItemCollection<Self>.self, from: response.data)

    guard let item = items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return item
  }

  internal func equivalentURL(storefront: String, path: EquivalentMusicItemType) throws -> URL {
    var components = AppleMusicURLComponents()

    components.path = "catalog/\(storefront)/\(path.rawValue)"
    components.queryItems = [URLQueryItem(name: "filter[equivalents]", value: id.rawValue)]

    guard let url = components.url else {
      throw URLError(.badURL)
    }
    return url
  }
}
