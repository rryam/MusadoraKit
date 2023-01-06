//
//  LibraryPlaylist.swift
//  LibraryPlaylist
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit
import MediaPlayer

public extension MLibrary {
  /// Fetch a playlist from the user's library by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  /// - Returns: `Playlist` matching the given identifier.
  static func playlist(with id: MusicItemID) async throws -> Playlist {
    let request = MLibraryResourceRequest<Playlist>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let playlist = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return playlist
  }

  /// Fetch all playlists from the user's library in alphabetical order.
  /// - Parameters:
  ///   - limit: The number of playlists returned.
  /// - Returns: `Playlists` for the given limit.
  static func playlists(limit: Int? = nil) async throws -> Playlists {
    var request = MLibraryResourceRequest<Playlist>()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple playlists from the user's library by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  /// - Returns: `Playlists` matching the given identifiers.
  static func playlists(with ids: [MusicItemID]) async throws -> Playlists {
    let request = MLibraryResourceRequest<Playlist>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return response.items
  }

#if compiler(>=5.7)
  /// Access the total number of playlists in the user's library.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static var playlistsCount: Int {
    get async throws {
      let request = MusicLibraryRequest<Playlist>()
      let response = try await request.response()
      return response.items.count
    }
  }
#else
  /// Access the total number of playlists in the user's library.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  @available(tvOS, unavailable)
  @available(watchOS, unavailable)
  static var playlistsCount: Int {
    get async throws {
      if let items = MPMediaQuery.playlists().items {
        return items.count
      } else {
        throw MediaPlayError.notFound(for: "playlists")
      }
    }
  }
#endif

  /// Add a playlist to the user's library by using its identifier.
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the playlist.
  /// - Returns: `Bool` indicating if the insert was successfull or not.
  static func addPlaylistToLibrary(id: MusicItemID) async throws -> Bool {
    let request = MAddResourcesRequest([(item: .playlists, value: [id])])
    let response = try await request.response()
    return response
  }

  /// Add multiple playlists to the user's library by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the playlists.
  /// - Returns: `Bool` indicating if the insert was successfull or not.
  static func addPlaylistsToLibrary(ids: [MusicItemID]) async throws -> Bool {
    let request = MAddResourcesRequest([(item: .playlists, value: ids)])
    let response = try await request.response()
    return response
  }

}

#if compiler(>=5.7)
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
public extension MLibrary {
  /// Fetch recently added playlists from the user's library sorted by the date added.
  ///
  /// - Parameters:
  ///   - limit: The number of playlists returned.
  /// - Returns: `Playlists` for the given limit.
  static func recentlyAddedPlaylists(limit: Int = 10, offset: Int = 0) async throws -> Playlists {
    var request = MusicLibraryRequest<Playlist>()
    request.limit = limit
    request.offset = offset
    request.sort(by: \.libraryAddedDate, ascending: false)
    let response = try await request.response()
    return response.items
  }

  /// Fetch recently played playlists from the user's library sorted by the date added.
  ///
  /// - Parameters:
  ///   - limit: The number of playlists returned.
  /// - Returns: `Playlists` for the given limit.
  static func recentlyPlayedPlaylists(limit: Int = 0, offset: Int = 0) async throws -> Playlists {
    var request = MusicLibraryRequest<Playlist>()
    request.limit = limit
    request.offset = offset
    request.sort(by: \.lastPlayedDate, ascending: false)
    let response = try await request.response()
    return response.items
  }
}
#endif

// MARK: - `LibraryPlaylist` methods
extension MLibrary {

  /// Fetch all playlists from the user's library in alphabetical order.
  /// - Returns: `LibraryPlaylists` for the given limit.
  static func playlists() async throws -> LibraryPlaylists {
    let playlistsURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists")!
    let request = MusicDataRequest(urlRequest: .init(url: playlistsURL))
    let response = try await request.response()

    var playlists = try JSONDecoder().decode(LibraryPlaylists.self, from: response.data)

    repeat {
      if let nextBatchOfPlaylists = try await playlists.nextBatch() {
        playlists += nextBatchOfPlaylists
      } else {
        break
      }
    } while playlists.hasNextBatch

    return playlists
  }
}
