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

public extension MCatalog {

  /// Fetches an equivalent music item from a specific storefront by its identifier.
  ///
  /// Use this method to retrieve a music item, such as a song or album, from a particular Apple Music storefront
  /// using its identifier. The method takes a generic type `T` conforming to the `StorefrontRequestable` protocol, allowing you to
  /// specify the expected type of music item. This ensures type safety and avoids the need for manual casting.
  ///
  /// Because a music item might have variations or equivalents in different storefronts, this method
  /// uses the `filter[equivalents]` query parameter to find the appropriate equivalent in the target storefront.
  ///
  /// Example:
  ///
  /// ```swift
  /// let songID: MusicItemID = "1642657180" // Example song ID
  /// let usStorefront = "us"
  ///
  /// do {
  ///     let usSong: Song = try await MCatalog.equivalent(id: songID, targetStorefront: usStorefront)
  ///     print("US Equivalent Song: \(usSong.title)")
  ///
  ///     let gbStorefront = "gb"
  ///     let gbSong: Song = try await MCatalog.equivalent(id: songID, targetStorefront: gbStorefront)
  ///     print("GB Equivalent Song: \(gbSong.title)")
  ///
  /// } catch {
  ///     print("Error fetching equivalent song: \(error)")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - id: The `MusicItemID` of the music item to fetch.
  ///   - targetStorefront: The ID of the target storefront (e.g., "us" for the United States).
  /// - Returns: The equivalent music item of type `T` found in the specified storefront.
  /// - Throws:
  ///     - An error if the network request fails or the response cannot be decoded.
  static func equivalent<T: StorefrontRequestable>(id: MusicItemID, targetStorefront: String) async throws -> MusicItemCollection<T> {
    let url = try equivalentEndpointURL(id: id, targetStorefront: targetStorefront, type: T.self)

    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(MusicItemCollection<T>.self, from: response.data)
    return items
  }
}

extension MCatalog {
  internal static func equivalentEndpointURL<T: StorefrontRequestable>(
    id: MusicItemID,
    targetStorefront: String,
    type: T.Type
  ) throws -> URL {
    var components = AppleMusicURLComponents()
    components.path = "catalog/\(targetStorefront)/\(T.resourcePath)"
    components.queryItems = [URLQueryItem(name: "filter[equivalents]", value: id.rawValue)]

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    return url
  }
}
