//
//  "So, I heard you whisper my name,
//  At once, I knew it was always me.
//  I cling to all the moments that we shared,
//  Nobody else could ever compare."
//
//  CreatePlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/11/22.
//

import Foundation

@available(macOS 14.0, *)
public extension MLibrary {

  /// Creates a new playlist in the user’s music library.
  ///
  /// Use this function to create a new playlist with the given name, description, and author's display name.
  /// If the author name is not provided, the playlist will be created with your app's name as the author.
  /// The description for the playlist is optional and can be used to provide additional details about the playlist.
  ///
  /// Example usage:
  ///
  ///     let playlistName = "My Awesome Playlist"
  ///     let authorName = "DJ Cool"
  ///     let playlistDescription = "A playlist full of cool tracks"
  ///
  ///     do {
  ///         let newPlaylist = try await MLibrary.createPlaylist(with: playlistName, author: authorName, description: playlistDescription)
  ///         print("New playlist created: \(newPlaylist.name)")
  ///     } catch {
  ///         print("Failed to create playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - name: The name of the playlist.
  ///   - author: An optional string containing the author's display name. If this is `nil`, your app's name will be used as the author's name.
  ///   - description: An optional string describing the playlist.
  /// - Returns: A `Playlist` object representing the newly created playlist.
  /// - Throws: An error if the playlist could not be created.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func createPlaylist(with name: String, author: String? = nil, description: String? = nil) async throws -> Playlist {
    try await MusicLibrary.shared.createPlaylist(name: name, description: description, authorDisplayName: author)
  }

  /// Creates a new playlist in the user’s music library with a set of songs.
  ///
  /// Use this function to create a new playlist with the given name, description, author's display name, and songs.
  /// If the author name is not provided, the playlist will be created with your app's name as the author.
  /// The description for the playlist is optional and can be used to provide additional details about the playlist.
  ///
  /// Example usage:
  ///
  ///     let playlistName = "My Awesome Playlist"
  ///     let authorName = "DJ Cool"
  ///     let playlistDescription = "A playlist full of cool tracks"
  ///     let songs: Songs = [...] // Initialize with the desired songs
  ///
  ///     do {
  ///         let newPlaylist = try await MLibrary.createPlaylist(with: playlistName, author: authorName, description: playlistDescription, items: songs)
  ///         print("New playlist created: \(newPlaylist.name)")
  ///     } catch {
  ///         print("Failed to create playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - name: The name of the playlist.
  ///   - author: An optional string containing the author's display name. If this is `nil`, your app's name will be used as the author's name.
  ///   - description: An optional string describing the playlist.
  ///   - items: A `Songs` object representing the songs to be added to the playlist.
  /// - Returns: A `Playlist` object representing the newly created playlist.
  /// - Throws: An error if the playlist could not be created.
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  static func createPlaylist(with name: String, author: String? = nil, description: String? = nil, items: Songs) async throws -> Playlist {
    try await MusicLibrary.shared.createPlaylist(name: name, description: description, authorDisplayName: author, items: items)
  }

  /// Creates a new playlist in the user’s music library.
  ///
  /// Use this function to create a new playlist in the user's library. Provide a name for the playlist, and an optional description.
  ///
  /// Example usage:
  ///
  ///     let playlistName = "My Favorite Songs"
  ///     let playlistDescription = "A collection of my all-time favorite songs."
  ///
  ///     do {
  ///         let newPlaylist = try await MLibrary.createPlaylist(with: playlistName, description: playlistDescription)
  ///         print("New playlist created: \(newPlaylist.name)")
  ///     } catch {
  ///         print("Failed to create playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - name: The name for the new playlist.
  ///   - description: An optional description for the playlist.
  /// - Returns: A `Playlist` object representing the newly created playlist.
  /// - Throws: An error if the playlist could not be created.
  /// - Note: This method uses the `LibraryPlaylistCreationRequest` which is available only for iOS 15 and older versions.
  static func createPlaylist(with name: String, description: String? = nil) async throws -> Playlist {
    let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description))
    return try await createPlaylist(with: creationRequest)
  }

  /// Creates a new playlist in the user’s music library and adds songs to it.
  ///
  /// Use this function to create a new playlist in the user's library. Provide a name for the playlist, an optional description, and a list of songs to be added to the playlist.
  ///
  /// Example usage:
  ///
  ///     let playlistName = "My Favorite Songs"
  ///     let playlistDescription = "A collection of my all-time favorite songs."
  ///     let songs = [song1, song2, song3] // Assume these are existing Song objects
  ///
  ///     do {
  ///         let newPlaylist = try await MLibrary.createPlaylist(with: playlistName, description: playlistDescription, items: songs)
  ///         print("New playlist created: \(newPlaylist.name)")
  ///     } catch {
  ///         print("Failed to create playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - name: The name for the new playlist.
  ///   - description: An optional description for the playlist.
  ///   - items: A list of `Song` objects to be added to the playlist.
  /// - Returns: A `Playlist` object representing the newly created playlist.
  /// - Throws: An error if the playlist could not be created.
  static func createPlaylist(with name: String, description: String? = nil, items: Songs) async throws -> Playlist {
    let tracksData: [PlaylistCreationData] = items.map { .init(id: $0.id.rawValue, type: .song)}

    let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description), relationships: .init(tracks: .init(data: tracksData)))
    return try await createPlaylist(with: creationRequest)
  }

  /// Creates a new playlist in the user’s music library using song identifiers.
  ///
  /// Use this function to create a new playlist in the user's library with a given list of song identifiers.
  /// Provide a name for the playlist, an optional description, and an array of song identifiers.
  ///
  /// Example usage:
  ///
  ///     let playlistName = "My Favorite Songs"
  ///     let playlistDescription = "A collection of my all-time favorite songs."
  ///     let songIDs = ["id1", "id2", "id3"] // Assume these are valid song identifiers
  ///
  ///     do {
  ///         let newPlaylist = try await MLibrary.createPlaylist(with: playlistName, description: playlistDescription, songIds: songIDs)
  ///         print("New playlist created: \(newPlaylist.name)")
  ///     } catch {
  ///         print("Failed to create playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - name: The name for the new playlist.
  ///   - description: An optional description for the playlist.
  ///   - songIds: An array of song identifiers. These are used to add songs to the new playlist.
  /// - Returns: A `Playlist` object representing the newly created playlist.
  /// - Throws: An error if the playlist could not be created.
  static func createPlaylist(with name: String, description: String? = nil, songIds: [MusicItemID]) async throws -> Playlist {
    let tracksData: [PlaylistCreationData] = songIds.map { .init(id: $0.rawValue, type: .song) }

    let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description), relationships: .init(tracks: .init(data: tracksData)))
    return try await createPlaylist(with: creationRequest)
  }

  /// Creates a new playlist in the user’s music library using track objects.
  ///
  /// This function is used to create a new playlist in the user's music library with a given list of track objects.
  /// Provide a name for the playlist, an optional description, and an array of track objects.
  ///
  /// Example usage:
  ///
  ///     let playlistName = "My Favorite Tracks"
  ///     let playlistDescription = "A collection of my all-time favorite tracks."
  ///     let trackItems: [Tracks] = ... // Obtain these from the music library
  ///
  ///     do {
  ///         let newPlaylist = try await MLibrary.createPlaylist(with: playlistName, description: playlistDescription, items: trackItems)
  ///         print("New playlist created: \(newPlaylist.name)")
  ///     } catch {
  ///         print("Failed to create playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - name: The name for the new playlist.
  ///   - description: An optional description for the playlist.
  ///   - items: An array of track objects. These are used to add tracks to the new playlist.
  /// - Returns: A `Playlist` object representing the newly created playlist.
  /// - Throws: An error if the playlist could not be created.
  static func createPlaylist(with name: String, description: String? = nil, items: Tracks) async throws -> Playlist {
    let tracksData: [PlaylistCreationData] = try items.compactMap {
      let data = try JSONEncoder().encode($0.playParameters)
      let playParameters = try JSONDecoder().decode(MusicPlayParameters.self, from: data)
      let id = playParameters.id.rawValue

      if playParameters.kind == "song" {
        if let isLibrary = playParameters.isLibrary, isLibrary {
          return PlaylistCreationData(id: id, type: .librarySong)
        } else {
          return PlaylistCreationData(id: id, type: .song)
        }
      } else if playParameters.kind == "musicVideo" {
        if let isLibrary = playParameters.isLibrary, isLibrary {
          return PlaylistCreationData(id: id, type: .libraryMusicVideo)
        } else {
          return PlaylistCreationData(id: id, type: .musicVideo)
        }
      } else {
        return nil
      }
    }

    let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description), relationships: .init(tracks: .init(data: tracksData)))
    return try await createPlaylist(with: creationRequest)
  }

  /// Creates a new playlist in the user’s music library using an array of playlist-addable items.
  ///
  /// This function creates a new playlist in the user's music library. You provide a name for the playlist, an optional description, and an array of playlist-addable items.
  ///
  /// Example usage:
  ///
  ///     let playlistName = "My Favorite Songs"
  ///     let playlistDescription = "A collection of my favorite songs."
  ///     let playlistItems: [any PlaylistAddable] = ... // Obtain these from the music library
  ///
  ///     do {
  ///         let newPlaylist = try await MLibrary.createPlaylist(with: playlistName, description: playlistDescription, items: playlistItems)
  ///         print("New playlist created: \(newPlaylist.name)")
  ///     } catch {
  ///         print("Failed to create playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - name: The name for the new playlist.
  ///   - description: An optional description for the playlist.
  ///   - items: An array of items conforming to the `PlaylistAddable` protocol. These are used to add tracks to the new playlist.
  /// - Returns: A `Playlist` object representing the newly created playlist.
  /// - Throws: An error if the playlist could not be created.
  ///
  /// - Note: The array of items (`[any PlaylistAddable]`) should contain items conforming to the `PlaylistAddable` protocol. This means they should have a `playParameters` property that includes an `id` and a `kind` ("song" or "musicVideo"). The function will also check whether the item is from the library or not using the `isLibrary` property. Depending on these properties, the function will add the item to the playlist.
  static func createPlaylist(with name: String, description: String? = nil, items: [any PlaylistAddable]) async throws -> Playlist {
    let tracksData: [PlaylistCreationData] = try items.compactMap {
      let data = try JSONEncoder().encode($0.playParameters)
      let playParameters = try JSONDecoder().decode(MusicPlayParameters.self, from: data)
      let id = playParameters.id.rawValue

      if playParameters.kind == "song" {
        if let isLibrary = playParameters.isLibrary, isLibrary {
          return PlaylistCreationData(id: id, type: .librarySong)
        } else {
          return PlaylistCreationData(id: id, type: .song)
        }
      } else if playParameters.kind == "musicVideo" {
        if let isLibrary = playParameters.isLibrary, isLibrary {
          return PlaylistCreationData(id: id, type: .libraryMusicVideo)
        } else {
          return PlaylistCreationData(id: id, type: .musicVideo)
        }
      } else {
        return nil
      }
    }

    let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description), relationships: .init(tracks: .init(data: tracksData)))
    return try await createPlaylist(with: creationRequest)
  }

  /// Adds an array of songs, identified by their IDs, to a specified playlist in the user's music library.
  ///
  /// Example usage:
  ///
  ///     let songIDs: [MusicItemID] = ... // Obtain these from the music library
  ///     let playlistID: MusicItemID = ... // Obtain this from the music library
  ///
  ///     do {
  ///         let success = try await MLibrary.add(songIDs: songIDs, to: playlistID)
  ///         if success {
  ///             print("Songs successfully added to playlist.")
  ///         } else {
  ///             print("Failed to add songs to playlist.")
  ///         }
  ///     } catch {
  ///         print("Error adding songs to playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - songIDs: An array of `MusicItemID` objects representing the songs to be added to the playlist.
  ///   - playlistID: A `MusicItemID` object representing the playlist to which the songs should be added.
  /// - Returns: A Boolean value indicating whether the songs were successfully added to the playlist.
  /// - Throws: An error if the songs could not be added to the playlist.
  @discardableResult
  static func add(songIDs: [MusicItemID], to playlistID: MusicItemID) async throws -> Bool {
    let songData = songIDs.map { PlaylistCreationData(id: $0.rawValue, type: .song) }
    let tracks = PlaylistCreationTracks(data: songData)

    let url = URL(string: "https://api.music.apple.com/v1/me/library/playlists/\(playlistID.rawValue)/tracks")

    guard let url = url else {
      throw URLError(.badURL)
    }

    let data = try JSONEncoder().encode(tracks)

    let request = MDataPostRequest(url: url, data: data)
    let response = try await request.response()
    return response.urlResponse.statusCode == 201
  }

  /// Adds an array of songs to a specified playlist in the user's music library.
  ///
  /// Example usage:
  ///
  ///     let songs: [Song] = ... // Obtain these from the music library
  ///     let playlist: Playlist = ... // Obtain this from the music library
  ///
  ///     do {
  ///         let success = try await MLibrary.add(songs: songs, to: playlist)
  ///
  ///         if success {
  ///             print("Songs successfully added to playlist.")
  ///         } else {
  ///             print("Failed to add songs to playlist.")
  ///         }
  ///     } catch {
  ///         print("Error adding songs to playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - songs: An array of `Song` objects representing the songs to be added to the playlist.
  ///   - playlist: A `Playlist` object representing the playlist to which the songs should be added.
  /// - Returns: A Boolean value indicating whether the songs were successfully added to the playlist.
  /// - Throws: An error if the songs could not be added to the playlist.
  @discardableResult
  static func add(songs: Songs, to playlist: Playlist) async throws -> Bool {
    try await add(songIDs: songs.map(\.id), to: playlist.id)
  }

  static private func createPlaylist(with creationRequest: LibraryPlaylistCreationRequest) async throws -> Playlist {
    var components = AppleMusicURLComponents()
    components.path = "me/library/playlists"

    guard let url = components.url else {
      throw URLError(.badURL)
    }

    let data = try JSONEncoder().encode(creationRequest)

    let request = MDataPostRequest(url: url, data: data)
    let response = try await request.response()

    let playlists = try JSONDecoder().decode(Playlists.self, from: response.data)

    guard let playlist = playlists.first else {
      throw MusadoraKitError.notFound(for: creationRequest.attributes.name)
    }

    return playlist
  }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
public extension MLibrary {

  /// Adds an item (or items) to a specified playlist in the user's music library.
  ///
  /// Example usage:
  ///
  ///     let songs: Songs = ... // Obtain these from the music library
  ///     let playlist: Playlist = ... // Obtain this from the music library
  ///
  ///     do {
  ///         let updatedPlaylist = try await MLibrary.add(item: songs, to: playlist)
  ///         print("Songs successfully added to \(updatedPlaylist.name).")
  ///     } catch {
  ///         print("Error adding songs to playlist: \(error)")
  ///     }
  ///
  /// - Parameters:
  ///   - item: An item conforming to `MusicPlaylistAddable` representing the music content to be added to the playlist.
  ///   - playlist: A `Playlist` object representing the playlist to which the songs should be added.
  /// - Returns: An updated `Playlist` object.
  /// - Throws: An error if the item could not be added to the playlist.
  @available(macOS 14.0, *)
  @discardableResult
  static func add(item: some MusicPlaylistAddable, to playlist: Playlist) async throws -> Playlist {
    try await MusicLibrary.shared.add(item, to: playlist)
  }
}
