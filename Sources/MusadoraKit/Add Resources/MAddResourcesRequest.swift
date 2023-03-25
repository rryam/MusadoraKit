//
//  MAddResourcesRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation

public typealias SongResource = (item: LibraryMusicItemType, value: [MusicItemID])

/// A request that your app uses to add one or more catalog resources to a user’s iCloud Music Library.
/// You can add multiple types in the same request.
public struct MAddResourcesRequest {
  private var resources: [(item: LibraryMusicItemType, value: [MusicItemID])]

  /// Creates a request to add multiple resources to the user's iCloud Music Library using their identifiers.
  public init(_ resources: [(item: LibraryMusicItemType, value: [MusicItemID])]) {
    self.resources = resources
  }

  /// Adds the given types to the user's iCloud Music Library and returns a successful/failure response.
  public func response() async throws -> Bool {
    let url = try addResourcesEndpointURL
    let request = MDataPostRequest(url: url)
    let response = try await request.response()
    return response.urlResponse.statusCode == 202
  }
}

extension MAddResourcesRequest {
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
