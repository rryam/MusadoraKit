//
//  APlayer.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 07/03/23.
//

import Foundation

/// A shorter alias for the ApplicationMusicPlayer
@available(macOS 14.0, macCatalyst 17.0, *)
@available(watchOS, unavailable)
public typealias APlayer = ApplicationMusicPlayer

@available(macOS 14.0, macCatalyst 17.0, *)
@available(watchOS, unavailable)
public extension APlayer {
  /// Plays the specified song in the player's queue.
  ///
  /// - Parameter song: The song to play.
  func play(song: Song) async throws {
    queue = [song]
    try await play()
  }

  /// Plays the specified collection of songs in the player's queue.
  ///
  /// - Parameter songs: The collection of songs to play.
  func play(songs: Songs) async throws {
    queue = APlayer.Queue(for: songs)
    try await play()
  }

  /// Plays the specified song at the specified position in the player's queue.
  ///
  /// - Parameters:
  ///   - song: The song to play.
  ///   - position: The position at which to insert the song in the player's queue.
  ///
  /// - Throws: An error if the song cannot be inserted in the queue or played.
  func play(song: Song, at position: APlayer.Queue.EntryInsertionPosition) async throws {
    try await queue.insert(song, position: position)
    try await play()
  }
}

@available(macOS 14.0, macCatalyst 17.0, *)
@available(watchOS, unavailable)
public extension APlayer {
  /// Plays the specified station in the player's queue.
  ///
  /// - Parameter station: The station to play.
  func play(station: Station) async throws {
    queue = [station]
    try await play()
  }
}

@available(macOS 14.0, macCatalyst 17.0, *)
@available(watchOS, unavailable)
public extension APlayer {
  /// Plays the specified playlist in the player's queue.
  ///
  /// - Parameter playlist: The playlist to play.
  func play(playlist: Playlist) async throws {
    queue = [playlist]
    try await play()
  }
}

@available(macOS 14.0, macCatalyst 17.0, *)
@available(watchOS, unavailable)
public extension APlayer {
  /// Plays the specified album in the player's queue.
  ///
  /// - Parameter album: The album to play.
  func play(album: Album) async throws {
    queue = [album]
    try await play()
  }
}

@available(iOS 16.0, tvOS 16.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
@available(watchOS, unavailable)
public extension APlayer {
  func play(album: MusicLibrarySection<Album, Song>) async throws {
    queue = ApplicationMusicPlayer.Queue(for: album.items)
    try await play()
  }
}

@available(iOS 16, *, tvOS 16, *, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
@available(watchOS, unavailable)
public extension APlayer {
  /// Plays the specified personalized music recommendation item in the player's queue.
  ///
  /// - Parameter item: The personalized music recommendation item to play, which can be an album, playlist, or station.
  /// - Throws: `MusadoraKitError.unsupportedRecommendationItemType` if the item type is not supported.
  func play(item: MusicPersonalRecommendation.Item) async throws {
    switch item {
    case .album(let album):
      queue = [album]
    case .playlist(let playlist):
      queue = [playlist]
    case .station(let station):
      queue = [station]
    @unknown default:
      throw MusadoraKitError.unsupportedRecommendationItemType
    }

    try await play()
  }
}

#if compiler(>=6.3)
@available(iOS 26.4, macOS 26.4, tvOS 26.4, visionOS 26.4, macCatalyst 26.4, *)
@available(watchOS, unavailable)
public extension APlayer {
  /// Plays the specified song, optionally preventing it from affecting the user's listening history.
  ///
  /// - Parameters:
  ///   - song: The song to play.
  ///   - affectsListeningHistory: Whether this queue should affect the user's listening history.
  func play(song: Song, affectsListeningHistory: Bool) async throws {
    queue = [song]
    queue.affectsListeningHistory = affectsListeningHistory
    try await play()
  }

  /// Plays the specified collection of songs, optionally preventing it from affecting the user's listening history.
  ///
  /// - Parameters:
  ///   - songs: The collection of songs to play.
  ///   - affectsListeningHistory: Whether this queue should affect the user's listening history.
  func play(songs: Songs, affectsListeningHistory: Bool) async throws {
    queue = APlayer.Queue(for: songs)
    queue.affectsListeningHistory = affectsListeningHistory
    try await play()
  }

  /// Plays the specified song at the specified position in the player's queue, optionally preventing it from
  /// affecting the user's listening history.
  ///
  /// - Parameters:
  ///   - song: The song to play.
  ///   - position: The position at which to insert the song in the player's queue.
  ///   - affectsListeningHistory: Whether this queue should affect the user's listening history.
  func play(song: Song, at position: APlayer.Queue.EntryInsertionPosition, affectsListeningHistory: Bool) async throws {
    try await queue.insert(song, position: position)
    queue.affectsListeningHistory = affectsListeningHistory
    try await play()
  }

  /// Plays the specified station, optionally preventing it from affecting the user's listening history.
  ///
  /// - Parameters:
  ///   - station: The station to play.
  ///   - affectsListeningHistory: Whether this queue should affect the user's listening history.
  func play(station: Station, affectsListeningHistory: Bool) async throws {
    queue = [station]
    queue.affectsListeningHistory = affectsListeningHistory
    try await play()
  }

  /// Plays the specified playlist, optionally preventing it from affecting the user's listening history.
  ///
  /// - Parameters:
  ///   - playlist: The playlist to play.
  ///   - affectsListeningHistory: Whether this queue should affect the user's listening history.
  func play(playlist: Playlist, affectsListeningHistory: Bool) async throws {
    queue = [playlist]
    queue.affectsListeningHistory = affectsListeningHistory
    try await play()
  }

  /// Plays the specified album, optionally preventing it from affecting the user's listening history.
  ///
  /// - Parameters:
  ///   - album: The album to play.
  ///   - affectsListeningHistory: Whether this queue should affect the user's listening history.
  func play(album: Album, affectsListeningHistory: Bool) async throws {
    queue = [album]
    queue.affectsListeningHistory = affectsListeningHistory
    try await play()
  }

  /// Plays the specified library album section, optionally preventing it from affecting the user's listening history.
  ///
  /// - Parameters:
  ///   - album: The library album section to play.
  ///   - affectsListeningHistory: Whether this queue should affect the user's listening history.
  func play(album: MusicLibrarySection<Album, Song>, affectsListeningHistory: Bool) async throws {
    queue = ApplicationMusicPlayer.Queue(for: album.items)
    queue.affectsListeningHistory = affectsListeningHistory
    try await play()
  }

  /// Plays the specified personalized music recommendation item, optionally preventing it from affecting the user's
  /// listening history.
  ///
  /// - Parameters:
  ///   - item: The personalized music recommendation item to play, which can be an album, playlist, or station.
  ///   - affectsListeningHistory: Whether this queue should affect the user's listening history.
  /// - Throws: `MusadoraKitError.unsupportedRecommendationItemType` if the item type is not supported.
  func play(item: MusicPersonalRecommendation.Item, affectsListeningHistory: Bool) async throws {
    switch item {
    case .album(let album):
      queue = [album]
    case .playlist(let playlist):
      queue = [playlist]
    case .station(let station):
      queue = [station]
    @unknown default:
      throw MusadoraKitError.unsupportedRecommendationItemType
    }

    queue.affectsListeningHistory = affectsListeningHistory
    try await play()
  }
}
#endif
