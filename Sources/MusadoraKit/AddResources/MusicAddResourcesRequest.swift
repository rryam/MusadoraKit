//
//  MusicAddResourcesRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation

/// A request structure for adding catalog resources to a user's library.
///
/// This structure enables adding multiple types of music items (songs, albums, playlists)
/// from the Apple Music catalog to the user's personal library in a single request.
///
/// Example usage:
/// ```swift
/// // Add multiple songs to the library
/// let songResources: SongResource = (.songs, ["1234567890", "0987654321"])
/// let request = MusicAddResourcesRequest(resources: [songResources])
///
/// do {
///     let response = try await request.response()
///     print("Successfully added songs to library")
/// } catch {
///     print("Failed to add resources: \(error)")
/// }
/// ```
public struct MusicAddResourcesRequest {
  /// The resources to be added to the library.
  /// Each resource is a tuple of the music item type and its identifiers.
  private var resources: [SongResource]

  /// Initializes a new `MusicAddResourcesRequest` to add multiple resources to the user's iCloud Music Library.
  ///
  /// - Parameter resources: An array of tuples where each tuple represents a type of music item
  /// and the music item IDs to add to the user's iCloud Music Library.
  public init(_ resources: [SongResource]) {
    self.resources = resources
  }

  /// Sends the request to add the given types of music items to the user's iCloud Music Library.
  ///
  /// - Returns: A boolean indicating whether the addition of the music items to the user's iCloud Music Library was successful.
  /// - Throws: An error if the request fails.
  public func response() async throws -> Bool {
    let url = try addResourcesEndpointURL
    let request = MusicPostRequest(url: url)
    let response = try await request.response()
    return response.urlResponse.statusCode == 202
  }
}

extension MusicAddResourcesRequest {
  /// A URL representing the endpoint for adding resources to the user's iCloud Music Library.
  ///
  /// - Returns: A URL object.
  /// - Throws: An error if the URL cannot be constructed.
  var addResourcesEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []
      components.path = "me/library"

      guard !resources.isEmpty else {
        throw MusadoraKitError.idMissing
      }

      let resourcesMap = Dictionary(grouping: resources, by: { $0.item })

      for (itemType, resources) in resourcesMap {
        let ids = resources.flatMap { $0.value }.map { $0.rawValue }
        let uniqueIds = Set(ids)
        guard !uniqueIds.isEmpty else {
          throw MusadoraKitError.idMissing
        }
        let values = uniqueIds.sorted().joined(separator: ",")
        let query = URLQueryItem(name: itemType.type, value: values)
        queryItems.append(query)
      }

      let sortedItems = queryItems.sorted { $0.name < $1.name }
      components.queryItems = sortedItems.isEmpty ? nil : sortedItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}

/// A tuple type representing a music resource to be added to the library.
///
/// - item: The type of music item (songs, albums, playlists)
/// - value: Array of unique identifiers for the items to be added
public typealias SongResource = (item: LibraryMusicItemType, value: [MusicItemID])
