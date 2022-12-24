//
//  LibraryArtists.swift
//  LibraryArtists
//
//  Created by Rudrank Riyam on 17/08/21.
//

import MusicKit
import MediaPlayer

public extension MLibrary {

#if compiler(>=5.7)
  /// Fetch an artist from the user's library by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  /// - Returns: `Artist` matching the given identifier.
  ///
  /// - Note: This method fetches the artist locally from the device when using iOS 16+
  ///  and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///  For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///  that fetches the data from Apple Music API.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func artist(for id: MusicItemID) async throws -> Artist {
    var request = MusicLibraryRequest<Artist>()
    request.filter(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let artist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return artist
  }
#else
  static func artist(for id: MusicItemID) async throws -> Artist {
    let request = MusicLibraryResourceRequest<Artist>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let artist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return artist
  }
#endif

  /// Fetch all artists from the user's library in alphabetical order.
  /// - Parameters:
  ///   - limit: The number of artists returned.
  /// - Returns: `Artists` for the given limit.
  static func artists(limit: Int? = nil) async throws -> Artists {
    var request = MusicLibraryResourceRequest<Artist>()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple artists from the user's library by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the artists.
  /// - Returns: `Artists` matching the given identifiers.
  static func artists(for ids: [MusicItemID]) async throws -> Artists {
    let request = MusicLibraryResourceRequest<Artist>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return response.items
  }

#if compiler(>=5.7)
  /// Access the total number of artists in the user's library.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static var artistsCount: Int {
    get async throws {
      let request = MusicLibraryRequest<Artist>()
      let response = try await request.response()
      return response.items.count
    }
  }
#else
  /// Access the total number of artists in the user's library.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  @available(tvOS, unavailable)
  @available(watchOS, unavailable)
  static var artistsCount: Int {
    get async throws {
      if let items = MPMediaQuery.artists().items {
        return items.count
      } else {
        throw MediaPlayError.notFound(for: "artists")
      }
    }
  }
#endif
}
