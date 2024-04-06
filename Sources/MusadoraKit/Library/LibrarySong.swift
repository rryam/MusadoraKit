//
//  "I'm gazing into you,
//  While you're scrolling through our shared memories,
//  Never considering anybody else."
//
//  LibrarySong.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MediaPlayer

public extension MLibrary {

  /// Fetch a song from the user's library by using its identifier.
  ///
  /// Use this method to retrieve a song from the user's library by providing its unique identifier.
  ///
  /// Example usage:
  ///
  ///     let songID: MusicItemID = "1544326470"
  ///     let song = try await MLibrary.song(id: songID)
  ///     print("Title: \(song.title)")
  ///     print("Artist: \(song.artistName)")
  ///     // ... access other properties
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the library song.
  /// - Returns: A `Song` object matching the given identifier.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if the song is not found.
  ///
  /// - Note: This method fetches the song locally from the device when using iOS 16+
  ///   and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///   For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///   that fetches the data from the Apple Music API.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func song(id: MusicItemID) async throws -> Song {
    if #available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      var request = MusicLibraryRequest<Song>()
      request.filter(matching: \.id, equalTo: id)
      let response = try await request.response()

      guard let song = response.items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return song
    } else {
      let request = MLibraryResourceRequest<Song>(matching: \.id, equalTo: id)
      let response = try await request.response()

      guard let song = response.items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return song
    }
  }

  /// Fetch all songs from the user's library in alphabetical order.
  ///
  /// Use this method to retrieve all songs from the user's library in alphabetical order.
  /// The function accepts a `limit` parameter to specify the maximum number of songs to be returned.
  ///
  /// Example usage:
  ///
  ///     let limit = 50
  ///     let allSongs = try await MLibrary.songs(limit: limit)
  ///
  ///     for song in allSongs {
  ///         print(song.title)
  ///     }
  ///
  /// - Parameters:
  ///   - limit: The maximum number of library songs to be returned (default is 50).
  /// - Returns: An array of `Song` objects representing all library songs from the user's library in alphabetical order.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues or invalid parameters.
  ///
  /// - Note: This method fetches the songs locally from the device when using iOS 16+
  ///   and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///   For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///   that fetches the data from the Apple Music API.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func songs(limit: Int = 50) async throws -> Songs {
    if #available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      if let _ = MusadoraKit.userToken {
        var request = MLibraryResourceRequest<Song>()
        request.limit = limit
        let response = try await request.response()
        return response.items
      } else {
        var request = MusicLibraryRequest<Song>()
        request.limit = limit
        let response = try await request.response()
        return response.items
      }
    } else {
      var request = MLibraryResourceRequest<Song>()
      request.limit = limit
      let response = try await request.response()
      return response.items
    }
  }

  /// Fetch multiple songs from the user's library by using their identifiers.
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the songs.
  /// - Returns: `Songs` matching the given identifiers.
  static func songs(ids: [MusicItemID]) async throws -> Songs {
    if #available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      var request = MusicLibraryRequest<Song>()
      request.filter(matching: \.id, memberOf: ids)
      let response = try await request.response()
      return response.items
    } else {
      let request = MLibraryResourceRequest<Song>(matching: \.id, memberOf: ids)
      let response = try await request.response()
      return response.items
    }
  }

  /// Fetch a song from the user's library by using its identifier with all properties from the local database.
  ///
  /// Use this method to fetch a song from the user's library by providing its unique identifier.
  /// The function retrieves the song with all available properties from the local database.
  ///
  /// Example usage:
  ///
  ///     let songID: MusicItemID = "1544326470"
  ///     let song = try await MLibrary.song(id: songID, fetch: .all)
  ///
  ///     print("Title: \(song.title)")
  ///     print("Artist: \(song.artistName)")
  ///     // ... access other properties
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the library song.
  ///   - properties: Additional properties to fetch with the library song.
  /// - Returns: A `Song` object matching the given identifier, with all available properties from the local database.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if the song is not found.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
  static func song(id: MusicItemID, fetch properties: SongProperties) async throws -> Song {
    var request = MusicLibraryRequest<Song>()
    request.filter(matching: \.id, equalTo: id)
    let response = try await request.response()

    guard let song = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return try await song.with(properties, preferredSource: .library)
  }

  /// Access the total number of songs in the user's library.
  ///
  /// Use this property to retrieve the total number of songs in the user's library.
  /// The property returns an integer value representing the count of songs.
  ///
  /// Example usage:
  ///
  ///     let count = try await MLibrary.songsCount
  ///     print("Total number of songs in the library: \(count)")
  ///
  /// - Returns: An `Int` representing the total number of songs in the user's library.
  /// - Throws: An error if the retrieval fails, such as access restrictions or unavailable platform.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
  static var songsCount: Int {
    get async throws {
      let request = MusicLibraryRequest<Playlist>()
      let response = try await request.response()
      return response.items.count
    }
  }

  /// Access the total number of songs in the user's library.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  @available(tvOS, unavailable)
  @available(watchOS, unavailable)
  static var songsItemsCount: Int {
    get async throws {
      if let items = MPMediaQuery.songs().items {
        return items.count
      } else {
        throw MediaPlayError.notFound(for: "songs")
      }
    }
  }

  /// Taken from https://github.com/marcelmendesfilho/MusadoraKit/blob/feature/improvements/Sources/MusadoraKit/Library/LibrarySong.swift
  /// Thanks @marcelmendesfilho!
  ///
  /// Add a song to the user's library by using its identifier.
  ///
  /// Use this method to add a song to the user's library by providing its unique identifier.
  /// The function accepts a `MusicItemID` representing the identifier of the song to be added.
  ///
  /// Example usage:
  ///
  ///     let songID: MusicItemID = "1544326470"
  ///     let success = try await MLibrary.addSong(id: songID)
  ///     if success {
  ///         print("Song was successfully added to the library.")
  ///     } else {
  ///         print("Failed to add the song to the library.")
  ///     }
  ///
  /// - Parameters:
  ///   - id: A `MusicItemID` representing the unique identifier of the song to be added.
  /// - Returns: A `Bool` indicating whether the insert operation was successful or not.
  /// - Throws: An error if the operation fails, such as network connectivity issues or invalid parameters.
  static func addSong(id: MusicItemID) async throws -> Bool {
    let song: SongResource = (item: .songs, value: [id])
    let request = MAddResourcesRequest([song])
    let response = try await request.response()
    return response
  }

  /// Add multiple songs to the user's library by using their identifiers.
  ///
  /// Use this method to add multiple songs to the user's library by providing their unique identifiers.
  /// The function accepts an array of `MusicItemID` representing the identifiers of the songs to be added.
  ///
  /// Example usage:
  ///
  ///     let songIDs: [MusicItemID] = ["1544326470", "1450695739", "1625489342"]
  ///     let success = try await MLibrary.addSongs(ids: songIDs)
  ///     if success {
  ///         print("Songs were successfully added to the library.")
  ///     } else {
  ///         print("Failed to add songs to the library.")
  ///     }
  ///
  /// - Parameters:
  ///   - ids: An array of `MusicItemID` representing the unique identifiers of the songs to be added.
  /// - Returns: A `Bool` indicating whether the insert operation was successful or not.
  /// - Throws: An error if the operation fails, such as network connectivity issues or invalid parameters.
  static func addSongs(ids: [MusicItemID]) async throws -> Bool {
    let songs: SongResource = (item: .songs, value: ids)
    let request = MAddResourcesRequest([songs])
    let response = try await request.response()
    return response
  }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
public extension MLibrary {

  /// Fetch recently added songs from the user's library sorted by the date added.
  ///
  /// Use this method to retrieve a list of recently added songs from the user's library,
  /// sorted by the date they were added. You can specify the number of songs to be returned
  /// using the `limit` parameter. Additionally, you can specify an `offset` value to paginate
  /// through the results.
  ///
  /// Example usage:
  ///
  ///     let limit = 10
  ///     let offset = 0
  ///     let recentlyAddedSongs = try await MLibrary.recentlyAddedSongs(limit: limit, offset: offset)
  ///
  ///     for song in recentlyAddedSongs {
  ///         print(song.title)
  ///     }
  ///
  /// - Parameters:
  ///   - limit: The maximum number of songs to be returned (default is 25).
  ///   - offset: The offset value for pagination (default is 0).
  /// - Returns: An array of `Song` objects representing the recently added songs from the user's library.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues or invalid parameters.
  static func recentlyAddedSongs(limit: Int = 25, offset: Int) async throws -> Songs {
    var request = MusicLibraryRequest<Song>()
    request.limit = limit
    request.offset = offset
    request.sort(by: \.libraryAddedDate, ascending: false)
    let response = try await request.response()
    return response.items
  }

  /// Fetch recently played songs from the user's library sorted by the date added.
  ///
  /// Use this method to retrieve a list of recently played songs from the user's library,
  /// sorted by the date they were added. You can specify the number of songs to be returned
  /// using the `limit` parameter. Additionally, you can specify an `offset` value to paginate
  /// through the results.
  ///
  /// Example usage:
  ///
  ///     let limit = 10
  ///     let offset = 0
  ///     let recentlyLibraryPlayedSongs = try await MLibrary.recentlyLibraryPlayedSongs(limit: limit, offset: offset)
  ///
  ///     for song in recentlyLibraryPlayedSongs {
  ///         print(song.title)
  ///     }
  ///
  /// - Parameters:
  ///   - limit: The maximum number of songs to be returned (default is 25).
  ///   - offset: The offset value for pagination (default is 0).
  /// - Returns: An array of `Song` objects representing the recently played songs from the user's library.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues or invalid parameters.
  static func recentlyLibraryPlayedSongs(limit: Int = 25, offset: Int) async throws -> Songs {
    var request = MusicLibraryRequest<Song>()
    request.limit = limit
    request.offset = offset
    request.sort(by: \.lastPlayedDate, ascending: false)
    let response = try await request.response()
    return response.items
  }

  /// Fetch recently played songs sorted by the date added.
  ///
  /// Use this method to retrieve a list of recently played songs, sorted by the date they were added.
  /// You can specify the number of songs to be returned using the `limit` parameter.
  /// Additionally, you can specify an `offset` value to paginate through the results.
  ///
  /// Example usage:
  ///
  ///     let limit = 10
  ///     let offset = 0
  ///     let recentlyPlayedSongs = try await MLibrary.recentlyPlayedSongs(limit: limit, offset: offset)
  ///
  ///     for song in recentlyPlayedSongs {
  ///         print(song.title)
  ///     }
  ///
  /// - Parameters:
  ///   - limit: The maximum number of songs to be returned (default is 25).
  ///   - offset: The offset value for pagination (default is 0).
  /// - Returns: An array of `Song` objects representing the recently played songs.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues or invalid parameters.
  static func recentlyPlayedSongs(limit: Int = 25, offset: Int) async throws -> Songs {
    var request = MusicRecentlyPlayedRequest<Song>()
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response.items
  }
}

public extension MLibrary {

  /// Fetch all songs from the user's library for a specific genre.
  ///
  /// Use this method to retrieve all songs belonging to a specific genre in the user's music library.
  /// You can provide the genre, such as "Rock" or "Pop", and it returns all the songs within that genre.
  ///
  /// Example usage:
  ///
  ///     let genre = ... Rock Genre // replace with your genre
  ///     let songs = try await MLibrary.songs(for: genre)
  ///     for song in songs {
  ///         print("Song: \(song.title)")
  ///     }
  ///     // ... access other properties
  ///
  /// - Parameter genre: The `Genre` for which to retrieve the songs.
  /// - Returns: A `Songs` collection containing all the songs in the user's library belonging to the given genre.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if no songs are found for the given genre.
  ///
  /// - Note: This method fetches the songs locally from the device,
  ///   and is faster because it uses the latest `MusicLibraryRequest` structure.
  @available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
  static func songs(for genre: Genre) async throws -> Songs {
    var request = MusicLibraryRequest<Song>()
    request.filter(matching: \.genres, contains: genre)
    let response = try await request.response()
    return response.items
  }
}

public extension MLibrary {
  
  /// Fetch all songs from the user's library for all genres.
  ///
  /// Use this method to retrieve all songs in the user's music library, grouped by genre.
  /// This function will return a `SongsForGenres` collection which includes songs from all genres in the user's library.
  ///
  /// Example usage:
  ///
  ///     do {
  ///         let songsForGenres = try await MLibrary.songsForGenres()
  ///
  ///         for songsForGenre in songsForGenres {
  ///             print("Genre: \(songsForGenre.name)")
  ///             for song in songsForGenre.items {
  ///                 print("Song: \(song.title)")
  ///             }
  ///         }
  ///     } catch {
  ///         print("Error fetching songs for genres: \(error)")
  ///     }
  ///
  /// - Returns: A `SongsForGenres` collection where each element represents a genre and its corresponding songs in the user's library.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if no songs are found for the given genres.
  ///
  /// - Note: This method fetches the songs locally from the device,
  ///   and is faster because it uses the latest `MusicLibraryRequest` structure.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func songsForGenres() async throws -> SongsForGenres {
    if #available(macOS 14.2, macCatalyst 17.2, *) {
      let request = MusicLibrarySectionedRequest<Genre, Song>()
      let response = try await request.response()
      return response.sections
    } else {
      return []
    }
  }
  
  /// Fetch all songs from the user's library for all artists.
  ///
  /// Use this method to retrieve all songs in the user's music library, grouped by artist.
  /// This function will return a `SongsForArtists` collection which includes songs from all artists in the user's library.
  ///
  /// Example usage:
  ///
  ///     do {
  ///         let songsForArtists = try await MLibrary.songsForArtists()
  ///
  ///         for songsForArtist in songsForArtists {
  ///             print("Artist: \(songsForArtist.name)")
  ///             for song in songsForArtist.songs {
  ///                 print("Song: \(song.title)")
  ///             }
  ///         }
  ///     } catch {
  ///         print("Error fetching songs for artists: \(error)")
  ///     }
  ///
  /// - Returns: A `SongsForArtists` collection where each element represents an artist and its corresponding songs in the user's library.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if no songs are found for the given artists.
  ///
  /// - Note: This method fetches the songs locally from the device,
  ///   and is faster because it uses the latest `MusicLibrarySectionedRequest` structure.
  @available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
  static func songsForArtists() async throws -> SongsForArtists {
    let request = MusicLibrarySectionedRequest<Artist, Song>()
    let response = try await request.response()
    return response.sections
  }
  
  /// Fetch all songs from the user's library for all albums.
  ///
  /// Use this method to retrieve all songs in the user's music library, grouped by album.
  /// This function will return a `SongsForAlbums` collection which includes songs from all albums in the user's library.
  ///
  /// Example usage:
  ///
  ///     do {
  ///         let songsForAlbums = try await MLibrary.songsForAlbums()
  ///
  ///         for songsForAlbum in songsForAlbums {
  ///             print("Album: \(songsForAlbum.title)")
  ///             for song in songsForAlbum.songs {
  ///                 print("Song: \(song.title)")
  ///             }
  ///         }
  ///     } catch {
  ///         print("Error fetching songs for albums: \(error)")
  ///     }
  ///
  /// - Returns: A `SongsForAlbums` collection where each element represents an album and its corresponding songs in the user's library.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if no songs are found for the given albums.
  ///
  /// - Note: This method fetches the songs locally from the device,
  ///   and is faster because it uses the latest `MusicLibrarySectionedRequest` structure.
  @available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
  static func songsForAlbums() async throws -> SongsForAlbums {
    let request = MusicLibrarySectionedRequest<Album, Song>()
    let response = try await request.response()
    return response.sections
  }
  
  /// Fetch all songs from the user's library for all playlists.
  ///
  /// Use this method to retrieve all songs in the user's music library, grouped by playlist.
  /// This function will return a `SongsForPlaylists` collection which includes songs from all playlists in the user's library.
  ///
  /// Example usage:
  ///
  ///     do {
  ///         let songsForPlaylists = try await MLibrary.songsForPlaylists()
  ///
  ///         for songsForPlaylist in songsForPlaylists {
  ///             print("Playlist: \(songsForPlaylist.name)")
  ///             for song in songsForPlaylist.songs {
  ///                 print("Song: \(song.title)")
  ///             }
  ///         }
  ///     } catch {
  ///         print("Error fetching songs for playlists: \(error)")
  ///     }
  ///
  /// - Returns: A `SongsForPlaylists` collection where each element represents a playlist and its corresponding songs in the user's library.
  /// - Throws: An error if the retrieval fails, such as network connectivity issues, invalid parameters, or if no songs are found for the given playlists.
  ///
  /// - Note: This method fetches the songs locally from the device,
  ///   and is faster because it uses the latest `MusicLibrarySectionedRequest` structure.
  @available(iOS 16.0, macOS 14.0, macCatalyst 17.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *)
  static func songsForPlaylists() async throws -> SongsForPlaylists {
    let request = MusicLibrarySectionedRequest<Playlist, Song>()
    let response = try await request.response()
    return response.sections
  }
}
