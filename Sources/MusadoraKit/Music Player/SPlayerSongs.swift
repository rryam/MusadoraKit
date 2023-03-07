//
//  SPlayerSongs.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 07/03/23.
//

import Foundation
import MusicKit

@available(macOS, unavailable)
@available(watchOS, unavailable)
public extension SPlayer {
  func play(song: Song) async throws {
    queue = [song]
    try await play()
  }

  func play(songs: Songs) async throws {
    queue = SystemMusicPlayer.Queue(for: songs)
    try await play()
  }

  func play(song: Song, at position: SPlayer.Queue.EntryInsertionPosition) async throws {
    try await queue.insert(song, position: position)
    try await play()
  }
}
