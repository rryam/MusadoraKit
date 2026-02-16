//
//  SPlayerObserver.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/02/26.
//

#if compiler(>=6.3) && canImport(Observation)
import Observation

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
  public var queue: SPlayer.Queue

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
  public func setQueue(_ queue: SPlayer.Queue) {
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
