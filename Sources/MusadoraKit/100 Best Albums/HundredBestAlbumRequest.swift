//
//  HundredBestAlbumRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 19/05/24.
//

import Foundation

/// A request that your app uses to fetch albums from Apple Music's 100 Best Albums list.
///
/// This structure enables fetching detailed information about specific albums from Apple Music's
/// curated list of 100 best albums, including their position, artwork, and rich content.
///
/// Example usage:
/// ```swift
/// let request = HundredBestAlbumRequest(position: 1)
///
/// do {
///     let album = try await request.response()
///     print("Album at position 1: \(album.name)")
///     print("Artist: \(album.artistName)")
/// } catch {
///     print("Failed to fetch album: \(error)")
/// }
/// ```
public struct HundredBestAlbumRequest {
  /// The position of the album in the 100 Best Albums list (1-100).
  private let position: Int

  /// The storefront to fetch the album from (e.g., "us" for United States).
  private let storefront: String

  /// The region/language code for localized content (e.g., "en-us").
  private let region: String

  /// Creates a request to fetch an album from the 100 Best Albums list.
  ///
  /// - Parameters:
  ///   - position: The position of the album in the list (1-100).
  ///   - storefront: The storefront to fetch the album from (defaults to "us").
  ///   - region: The region/language code for localized content (defaults to "en-us").
  public init(position: Int, storefront: String = "us", region: String = "en-us") {
    self.position = position
    self.storefront = storefront
    self.region = region
  }

  /// Fetches the album at the specified position in the 100 Best Albums list.
  ///
  /// - Returns: A `HundredBestAlbum` object containing the album's details.
  /// - Throws: An error if the album cannot be fetched or if the response cannot be decoded.
  public func response() async throws -> HundredBestAlbum {
    let url = try albumEndpointURL
    return try await fetchAlbum(from: url)
  }

  /// Fetches and decodes the album data from the specified URL.
  ///
  /// - Parameter url: The URL to fetch the album data from.
  /// - Returns: A decoded `HundredBestAlbum` object.
  /// - Throws: An error if the data cannot be fetched or decoded.
  private func fetchAlbum(from url: URL) async throws -> HundredBestAlbum {
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(HundredBestAlbum.self, from: data)
  }
}

/// Extension containing URL-related functionality for the album request.
extension HundredBestAlbumRequest {
  /// The URL used to fetch the album data.
  ///
  /// - Returns: A URL constructed using the storefront, region, and position.
  /// - Throws: `URLError.badURL` if the URL cannot be constructed.
  internal var albumEndpointURL: URL {
    get throws {
      var components = URLComponents()
      components.scheme = "https"
      components.host = "100best.music.apple.com"
      components.path = "/content/\(storefront)/\(region)/\(position).json"

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      return url
    }
  }
}
