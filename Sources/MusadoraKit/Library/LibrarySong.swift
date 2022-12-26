//
//  LibrarySong.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit
import MediaPlayer

public extension MLibrary {

#if compiler(>=5.7)
  /// Fetch a song from the user's library by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  /// - Returns: `Song` matching the given identifier.
  ///
  /// - Note: This method fetches the song locally from the device when using iOS 16+
  ///  and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///  For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///  that fetches the data from Apple Music API.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func song(for id: MusicItemID) async throws -> Song {
    var request = MusicLibraryRequest<Song>()
    request.filter(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let song = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return song
  }
#else
  static func song(for id: MusicItemID) async throws -> Song {
    let request = MusicLibraryResourceRequest<Song>(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let song = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return song
  }
#endif

#if compiler(>=5.7)
  /// Fetch all songs from the user's library in alphabetical order.
  /// - Parameters:
  ///   - limit: The number of songs returned.
  /// - Returns: `Songs` for the given limit.
  ///
  /// - Note: This method fetches the song locally from the device when using iOS 16+
  ///  and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///  For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///  that fetches the data from Apple Music API.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func songs(limit: Int? = 50) async throws -> Songs {
    let request = MusicLibraryRequest<Song>()
    let response = try await request.response()
    return response.items
  }
#else
  static func songs(limit: Int? = nil) async throws -> Songs {
    var request = MusicLibraryResourceRequest<Song>()
    request.limit = limit
    let response = try await request.response()
    return response.items
  }
#endif

  /// Fetch multiple songs from the user's library by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func songs(ids: [MusicItemID]) async throws -> Songs {
    let request = MusicLibraryResourceRequest<Song>(matching: \.id, memberOf: ids)
    let response = try await request.response()
    return response.items
  }

#if compiler(>=5.7)
  /// Fetch a song from the user's library by using its identifier with all properties from the local database.
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  /// - Returns: `Song` matching the given identifier.
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func librarySong(id: MusicItemID, with properties: SongProperties = .all) async throws -> Song {
    var request = MusicLibraryRequest<Song>()
    request.filter(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let song = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return try await song.with(properties)
  }
#endif

#if compiler(>=5.7)
  /// Access the total number of songs in the user's library.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static var songsCount: Int {
    get async throws {
      let request = MusicLibraryRequest<Song>()
      let response = try await request.response()
      return response.items.count
    }
  }
#else
  /// Access the total number of songs in the user's library.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  @available(tvOS, unavailable)
  @available(watchOS, unavailable)
  static var songsCount: Int {
    get async throws {
      if let items = MPMediaQuery.songs().items {
        return items.count
      } else {
        throw MediaPlayError.notFound(for: "songs")
      }
    }
  }
#endif

  /// Taken from https://github.com/marcelmendesfilho/MusadoraKit/blob/feature/improvements/Sources/MusadoraKit/Library/LibrarySong.swift
  /// Thanks @marcelmendesfilho!
  /// Add a song to the user's library by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the song.
  /// - Returns: `Bool` indicating if the insert was successfull or not.
  static func addSong(for id: MusicItemID) async throws -> Bool {
    let song: SongResource = (item: .songs, value: [id])
    let request = MAddResourcesRequest([song])
    let response = try await request.response()
    return response
  }

  /// Add multiple songs to the user's library by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  /// - Returns: `Bool` indicating if the insert was successfull or not.
  static func addSongs(for ids: [MusicItemID]) async throws -> Bool {
    let songs: SongResource = (item: .songs, value: ids)
    let request = MAddResourcesRequest([songs])
    let response = try await request.response()
    return response
  }
}

#if compiler(>=5.7)
@available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
public extension MLibrary {
  /// Fetch recently added songs from the user's library sorted by the date added.
  /// - Parameters:
  ///   - limit: The number of songs returned.
  /// - Returns: `Songs` for the given limit.
  static func recentlyAddedSongs(limit: Int = 10, offset: Int = 0) async throws -> Songs {
    var request = MusicLibraryRequest<Song>()
    request.limit = limit
    request.offset = offset
    request.sort(by: \.libraryAddedDate, ascending: false)
    let response = try await request.response()
    return response.items
  }

  /// Fetch recently played songs from the user's library sorted by the date added.
  /// - Parameters:
  ///   - limit: The number of songs returned.
  /// - Returns: `Songs` for the given limit.
  static func recentlyLibraryPlayedSongs(limit: Int = 0, offset: Int = 0) async throws -> Songs {
    var request = MusicLibraryRequest<Song>()
    request.limit = limit
    request.offset = offset
    request.sort(by: \.lastPlayedDate, ascending: false)
    let response = try await request.response()
    return response.items
  }

  /// Fetch recently played songs sorted by the date added.
  /// - Parameters:
  ///   - limit: The number of songs returned.
  /// - Returns: `Songs` for the given limit.
  @available(macOS 13.0, *)
  static func recentlyPlayedSongs(limit: Int = 0, offset: Int = 0) async throws -> Songs {
    var request = MusicRecentlyPlayedRequest<Song>()
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.items
  }
}
#endif
