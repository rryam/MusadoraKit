//
//  LibraryAlbum.swift
//  LibraryAlbum
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit
import MediaPlayer

public extension MusadoraKit {
#if compiler(>=5.7)
  /// Fetch an album from the user's library by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the album.
  /// - Returns: `Album` matching the given identifier.
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  static func libraryAlbum(id: MusicItemID) async throws -> Album {
    var request = MusicLibraryRequest<Album>()
    request.filter(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let album = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return album
  }
#else
  static func libraryAlbum(id: MusicItemID) async throws -> Album {
    let request = MusicLibraryResourceRequest<Album>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let album = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return album
  }
#endif

#if compiler(>=5.7)
  /// Fetch all albums from the user's library in alphabetical order.
  /// - Parameters:
  ///   - limit: The number of albums returned.
  /// - Returns: `Albums` for the given limit.
  @available(iOS 16, tvOS 16.0, watchOS 9.0, *)
  static func libraryAlbums(limit: Int = 50) async throws -> Albums {
    var request = MusicLibraryRequest<Album>()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }
#else
  static func libraryAlbums(limit: Int = 50) async throws -> Albums {
    var request = MusicLibraryResourceRequest<Album>()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }
#endif

  /// Fetch multiple albums from the user's library by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the albums.
  /// - Returns: `Albums` matching the given identifiers.
  static func libraryAlbums(ids: [MusicItemID]) async throws -> Albums {
    let request = MusicLibraryResourceRequest<Album>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return response.items
  }

  static var libraryAlbumsCount: Int {
    get async throws {
      if let items = MPMediaQuery.albums().items {
        return items.count
      } else {
        throw MediaPlayError.notFound(for: "albums")
      }
    }
  }
}

