//
//  MusicPlayerObservers.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/02/26.
//

#if compiler(>=6.3) && canImport(Observation)
import Observation

/// An `@Observable` wrapper around `ApplicationMusicPlayer` for SwiftUI-friendly observation.
///
/// MusicKit 26.4 introduces `Observation.Observable` conformances for `MusicPlayer.Queue` and `MusicPlayer.State`.
/// This type packages `player`, `queue`, and `state` into a single model that can be stored in SwiftUI state and
/// kept in sync when you swap the underlying queue.
@available(iOS 26.4, macOS 26.4, tvOS 26.4, visionOS 26.4, macCatalyst 26.4, *)
@available(watchOS, unavailable)
@Observable
public final class APlayerObserver {
  /// The underlying MusicKit player.
  public let player: APlayer

  /// A reference to the player's queue.
  ///
  /// - Note: MusicKit models can replace the queue instance when you assign a new queue. Use `sync()` (or
  /// `setQueue(_:)`) to refresh this reference if needed.
  public var queue: APlayer.Queue

  /// A reference to the player's state.
  public let state: MusicPlayer.State

  /// Creates an observer for the provided player.
  ///
  /// - Parameter player: The player to observe. Defaults to `ApplicationMusicPlayer.shared`.
  public init(player: APlayer = .shared) {
    self.player = player
    self.queue = player.queue
    self.state = player.state
  }

  /// Refreshes `queue` from the underlying `player`.
  public func sync() {
    queue = player.queue
  }

  /// Sets a new queue on the underlying player and updates `queue`.
  ///
  /// - Parameter queue: The new queue to assign.
  public func setQueue(_ queue: APlayer.Queue) {
    player.queue = queue
    sync()
  }

  /// Starts playback.
  public func play() async throws {
    try await player.play()
  }

  /// Pauses playback.
  public func pause() {
    player.pause()
  }

  /// Skips to the next entry.
  public func skipToNextEntry() async throws {
    try await player.skipToNextEntry()
  }

  /// Skips to the previous entry.
  public func skipToPreviousEntry() async throws {
    try await player.skipToPreviousEntry()
  }
}

/// An `@Observable` wrapper around `SystemMusicPlayer` for SwiftUI-friendly observation.
@available(iOS 26.4, tvOS 26.4, visionOS 26.4, macCatalyst 26.4, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@Observable
public final class SPlayerObserver {
  /// The underlying MusicKit player.
  public let player: SPlayer

  /// A reference to the player's queue.
  ///
  /// - Note: MusicKit models can replace the queue instance when you assign a new queue. Use `sync()` (or
  /// `setQueue(_:)`) to refresh this reference if needed.
  public var queue: MusicPlayer.Queue

  /// A reference to the player's state.
  public let state: MusicPlayer.State

  /// Creates an observer for the provided player.
  ///
  /// - Parameter player: The player to observe. Defaults to `SystemMusicPlayer.shared`.
  public init(player: SPlayer = .shared) {
    self.player = player
    self.queue = player.queue
    self.state = player.state
  }

  /// Refreshes `queue` from the underlying `player`.
  public func sync() {
    queue = player.queue
  }

  /// Sets a new queue on the underlying player and updates `queue`.
  ///
  /// - Parameter queue: The new queue to assign.
  public func setQueue(_ queue: MusicPlayer.Queue) {
    player.queue = queue
    sync()
  }

  /// Starts playback.
  public func play() async throws {
    try await player.play()
  }

  /// Pauses playback.
  public func pause() {
    player.pause()
  }

  /// Skips to the next entry.
  public func skipToNextEntry() async throws {
    try await player.skipToNextEntry()
  }

  /// Skips to the previous entry.
  public func skipToPreviousEntry() async throws {
    try await player.skipToPreviousEntry()
  }
}

#endif

