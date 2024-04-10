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

  @available(iOS 16.0, tvOS 16.0, visionOS 1.0, *)
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
  func play(item: MusicPersonalRecommendation.Item) async throws {
    switch item {
      case .album(let album):
        queue = [album]
      case .playlist(let playlist):
        queue = [playlist]
      case .station(let station):
        queue = [station]
      @unknown default:
        fatalError()
    }
    
    try await play()
  }
}
