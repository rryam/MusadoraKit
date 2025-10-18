// 
//  CatalogEquivalents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

import Foundation

public extension MusicItemCollection where MusicItemType: EquivalentRequestable {
  /// Fetches the equivalent music items for the given storefront.
  ///
  /// Example usage:
  ///
  ///     let albums: MusicItemCollection<Album> = ...
  ///     let equivalentAlbums = try await albums.equivalents(for: "us")
  ///
  /// - Parameters:
  ///   - targetStorefront: A string representing the storefront for which the equivalent music items should be fetched.
  ///
  /// - Returns: A collection of equivalent music items for the given storefront.
  func equivalents(for targetStorefront: String) async throws -> MusicItemCollection<MusicItemType> {
    let path = try EquivalentMusicItemType.path(for: MusicItemType.self)

    let url = try equivalentsURL(storefront: targetStorefront, path: path)
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(MusicItemCollection<MusicItemType>.self, from: response.data)
    return items
  }

  internal func equivalentsURL(storefront: String, path: EquivalentMusicItemType) throws -> URL {
    var components = AppleMusicURLComponents()

    components.path = "catalog/\(storefront)/\(path.rawValue)"
    let ids = self.map { $0.id.rawValue }.joined(separator: ",")
    components.queryItems = [URLQueryItem(name: "filter[equivalents]", value: ids)]

    guard let url = components.url else {
      throw URLError(.badURL)
    }
    return url
  }
}
