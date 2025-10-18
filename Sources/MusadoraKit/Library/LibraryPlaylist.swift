//
//  LibraryPlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MediaPlayer

public extension MLibrary {
  /// Fetch a playlist from the user's library by using its identifier.
  ///
  /// Use this method to retrieve a playlist from the user's library by providing its unique identifier.
  ///
  /// Example usage:
  ///
  ///     let playlistID: MusicItemID = "pl.u-9N9Lz6dFx7qBy64"
  ///     let playlist = try await MLibrary.playlist(id: playlistID)
  ///
  ///     print("Playlist: \(playlist.name)") // ✨POSITIVITY✨
  ///     print("Playlist Curator: \(playlist.curatorName)") // Rudrank Riyam
  ///
  ///     for song in playlist.tracks {
  ///         print("Song: \(song.title)")
  ///     }
  ///     // ... access other properties
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the library playlist.
  /// - Returns: A `Playlist` object matching the given identifier.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if the playlist is not found.
  ///
  /// - Note: This method fetches the playlist locally from the device when using iOS 16+
  ///   and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///   For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///   that fetches the data from the Apple Music API.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func playlist(id: MusicItemID) async throws -> Playlist {
    if #available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *) {
      var request = MusicLibraryRequest<Playlist>()
      request.filter(matching: \.id, equalTo: id)
      let response = try await request.response()

      guard let playlist = response.items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return playlist
    } else {
      let request = MLibraryResourceRequest<Playlist>(matching: \.id, equalTo: id)
      let response = try await request.response()

      guard let playlist = response.items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return playlist
    }
  }

  /// Fetch all playlists from the user's library in alphabetical order.
  ///
  /// Use this method to retrieve all playlists from the user's library, sorted in alphabetical order.
  /// You can also limit the number of results returned by providing an optional limit parameter.
  ///
  /// Example usage:
  ///
  ///     let playlists = try await MLibrary.playlists(limit: 10)
  ///
  ///     for playlist in playlists {
  ///         print("Playlist: \(playlist.name)")
  ///         print("Playlist Curator: \(playlist.curatorName)")
  ///
  ///         for song in playlist.tracks {
  ///             print("Song: \(song.title)")
  ///         }
  ///         // ... access other properties
  ///     }
  ///
  /// - Parameters:
  ///   - limit: An optional integer representing the maximum number of playlists to be returned. If no limit is provided, all playlists will be returned.
  /// - Returns: A `Playlists` collection containing up to the specified limit of playlists, or all playlists if no limit is provided.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if the playlists are not found.
  ///
  /// - Note: This method fetches the playlists locally from the device when using iOS 16+
  ///   and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///   For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///   that fetches the data from the Apple Music API.
  static func playlists(limit: Int? = nil) async throws -> Playlists {
    if #available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      var request = MusicLibraryRequest<Playlist>()
      if let limit {
        request.limit = limit
      }
      let response = try await request.response()
      return try await response.items.collectingAll(upTo: limit)
    } else {
      var request = MLibraryResourceRequest<Playlist>()
      request.limit = limit
      let response = try await request.response()
      return try await response.items.collectingAll(upTo: limit)
    }
  }

  /// Fetch multiple playlists from the user's library by using their identifiers.
  ///
  /// Use this method to retrieve a collection of playlists from the user's library by providing their unique identifiers.
  ///
  /// Example usage:
  ///
  ///     let playlistIDs: [MusicItemID] = ["pl.f4d106fed2bd41149aaacabb233eb5eb", "pl.d2d16b1be5754483985c4f054c0ca9d1"]
  ///     let playlists = try await MLibrary.playlists(ids: playlistIDs)
  ///
  ///     for playlist in playlists {
  ///         print("Playlist: \(playlist.name)")
  ///         print("Playlist Curator: \(playlist.curatorName)")
  ///
  ///         for song in playlist.tracks {
  ///             print("Song: \(song.title)")
  ///         }
  ///         // ... access other properties
  ///     }
  ///
  /// - Parameters:
  ///   - ids: An array of unique identifiers for the library playlists.
  /// - Returns: A `Playlists` collection matching the given identifiers.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if the playlists are not found.
  ///
  /// - Note: This method fetches the playlists locally from the device when using iOS 16+
  ///   and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///   For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///   that fetches the data from the Apple Music API.
  static func playlists(ids: [MusicItemID]) async throws -> Playlists {
    if #available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      var request = MusicLibraryRequest<Playlist>()
      request.filter(matching: \.id, memberOf: ids)
      let response = try await request.response()
      return response.items
    } else {
      let request = MLibraryResourceRequest<Playlist>(matching: \.id, memberOf: ids)
      let response = try await request.response()
      return response.items
    }
  }

  /// Access the total number of playlists in the user's library.
  ///
  /// Use this property to retrieve the total number of playlists in the user's library.
  /// The property returns an integer value representing the count of playlists.
  ///
  /// Example usage:
  ///
  ///     let count = try await MLibrary.playlistsCount
  ///     print("Total number of playlists in the library: \(count)")
  ///
  /// - Returns: An `Int` representing the total number of playlists in the user's library.
  /// - Throws: An error if the retrieval fails, such as access restrictions or unavailable platform.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
  static var playlistsCount: Int {
    get async throws {
      let request = MusicLibraryRequest<Playlist>()
      let collection = try await request.response().items.collectingAll()
      return collection.count
    }
  }

  /// Access the total number of playlists in the user's library.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  @available(tvOS, unavailable)
  @available(watchOS, unavailable)
  static var playlistsItemsCount: Int {
    get async throws {
      if let items = MPMediaQuery.playlists().items {
        return items.count
      } else {
        throw MediaPlayError.notFound(for: "playlists")
      }
    }
  }

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

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
public extension MHistory {
  /// Fetch recently added playlists from the user's library sorted by the date added.
  ///
  /// - Parameters:
  ///   - limit: The number of playlists returned.
  ///   - offset: The offset for pagination.
  /// - Returns: `Playlists` for the given limit.
  static func recentlyAddedPlaylists(limit: Int = 25, offset: Int) async throws -> Playlists {
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
  ///   - offset: The offset for pagination.
  /// - Returns: `Playlists` for the given limit.
  static func recentlyPlayedPlaylists(limit: Int = 25, offset: Int) async throws -> Playlists {
    var request = MusicLibraryRequest<Playlist>()
    request.limit = limit
    request.offset = offset
    request.sort(by: \.lastPlayedDate, ascending: false)
    let response = try await request.response()
    return response.items
  }
}

// MARK: - `LibraryPlaylist` methods
public extension MLibrary {
  /// Fetch all playlists from the user's library in alphabetical order.
  ///
  /// - Returns: `LibraryPlaylists` that contains the user's library playlists.
  public static func playlists(limit: Int) async throws -> LibraryPlaylists {
    guard let url = try libraryPlaylistsURL(limit: limit) else {
      return LibraryPlaylists([])
    }

    var playlists: LibraryPlaylists = []
    let decoder = JSONDecoder()

    if let userToken = MusadoraKit.userToken {
      let request = MUserRequest(urlRequest: .init(url: url), userToken: userToken)
      let data = try await request.response()
      playlists = try decoder.decode(LibraryPlaylists.self, from: data)
    } else {
      let request = MusicDataRequest(urlRequest: .init(url: url))
      let response = try await request.response()
      playlists = try decoder.decode(LibraryPlaylists.self, from: response.data)
    }
    return try await playlists.collectingAll(upTo: limit)
  }

  /// Fetch the user's "Made For You" playlists from their library.
  ///
  /// Use this method to retrieve a collection of playlists that have been curated by Apple Music's algorithm to match the user's music taste.
  ///
  /// Example usage:
  ///
  ///     let playlists = try await MLibrary.madeForYouPlaylists()
  ///
  ///     for playlist in playlists {
  ///         print("Playlist: \(playlist.name)")
  ///         print("Playlist Curator: \(playlist.curatorName)")
  ///
  ///         for song in playlist.tracks {
  ///             print("Song: \(song.title)")
  ///         }
  ///         // ... access other properties
  ///     }
  ///
  /// - Returns: A `LibraryPlaylists` object that contains the user's "Made For You" playlists.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if the playlists are not found.
  ///
  /// - Note: This method fetches the playlists from Apple Music's server using `MusicDataRequest` to perform a network request.
  ///   The response data is then decoded into a `LibraryPlaylists` object.
  public static func madeForYouPlaylists() async throws -> LibraryPlaylists {
    var components = AppleMusicURLComponents()
    components.path = "me/library/playlists"
    components.queryItems = [URLQueryItem(name: "filter[featured]", value: "made-for-you")]

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()

    let playlists = try JSONDecoder().decode(LibraryPlaylists.self, from: response.data)

    return try await playlists.collectingAll()
  }

  internal static func libraryPlaylistsURL(limit: Int) throws -> URL? {
    guard limit > 0 else { return nil }

    var components = AppleMusicURLComponents()
    components.path = "me/library/playlists"
    components.queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]

    return components.url
  }
}
