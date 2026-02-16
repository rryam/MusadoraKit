//
//  APlayer+TrackTimeBounds.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/02/26.
//

import Foundation

@available(macOS 14.0, macCatalyst 17.0, *)
@available(watchOS, unavailable)
public extension APlayer {
  /// Plays the specified track in the player's queue.
  ///
  /// On MusicKit 26.4+ (when built with a toolchain/SDK that includes it), this respects the track's
  /// `startTime` and `endTime` by constructing a queue entry with those bounds.
  ///
  /// - Parameter track: The track to play.
  func play(track: Track) async throws {
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, visionOS 26.4, macCatalyst 26.4, *) {
      let entry = MusicPlayer.Queue.Entry(track, startTime: track.startTime, endTime: track.endTime)
      queue = APlayer.Queue([entry])
      try await play()
      return
    }
    #endif

    queue = [track]
    try await play()
  }

  /// Plays the specified collection of tracks in the player's queue.
  ///
  /// On MusicKit 26.4+ (when built with a toolchain/SDK that includes it), this respects each track's
  /// `startTime` and `endTime` by constructing queue entries with those bounds.
  ///
  /// - Parameter tracks: The collection of tracks to play.
  func play(tracks: Tracks) async throws {
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, visionOS 26.4, macCatalyst 26.4, *) {
      let entries = tracks.map { MusicPlayer.Queue.Entry($0, startTime: $0.startTime, endTime: $0.endTime) }
      queue = APlayer.Queue(entries)
      try await play()
      return
    }
    #endif

    queue = APlayer.Queue(for: tracks)
    try await play()
  }
}
