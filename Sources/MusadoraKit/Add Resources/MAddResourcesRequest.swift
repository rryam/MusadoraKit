//
//  MAddResourcesRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation

/// A typealias for a tuple that associates a library music item type with a set of music item identifiers.
///
/// - item: The type of music item in the library, defined by `LibraryMusicItemType`.
/// - value: An array of `MusicItemID` instances representing the identifiers of music items of the specified type.
public typealias SongResource = (item: LibraryMusicItemType, value: [MusicItemID])

/// `MAddResourcesRequest` is a struct that encapsulates a request to add one or more catalog resources
/// to a user’s iCloud Music Library.
///
/// You can add multiple types of resources in the same request. Each resource is a tuple where `item`
/// represents the type of music item to add, and `value` is an array of `MusicItemID`s identifying the
/// items to add.
///
/// - Property `resources`: An array of tuples. Each tuple includes a music item type (`LibraryMusicItemType`)
/// and an array of music item IDs (`[MusicItemID]`).
public struct MAddResourcesRequest {
  private var resources: [(item: LibraryMusicItemType, value: [MusicItemID])]

  /// Initializes a new `MAddResourcesRequest` to add multiple resources to the user's iCloud Music Library.
  ///
  /// - Parameter resources: An array of tuples where each tuple represents a type of music item
  /// and the music item IDs to add to the user's iCloud Music Library.
  public init(_ resources: [(item: LibraryMusicItemType, value: [MusicItemID])]) {
    self.resources = resources
  }

  /// Sends the request to add the given types of music items to the user's iCloud Music Library.
  ///
  /// - Returns: A boolean indicating whether the addition of the music items to the user's iCloud Music Library was successful.
  /// - Throws: An error if the request fails.
  public func response() async throws -> Bool {
    let url = try addResourcesEndpointURL
    let request = MDataPostRequest(url: url)
    let response = try await request.response()
    return response.urlResponse.statusCode == 202
  }
}

extension MAddResourcesRequest {

  /// A URL representing the endpoint for adding resources to the user's iCloud Music Library.
  ///
  /// - Returns: A URL object.
  /// - Throws: An error if the URL cannot be constructed.
  var addResourcesEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []
      components.path = "me/library"

      for resource in resources {
        let values = resource.value.map { $0.rawValue }.joined(separator: ",")
        let query = URLQueryItem(name: resource.item.type, value: values)
        queryItems.append(query)
      }

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
