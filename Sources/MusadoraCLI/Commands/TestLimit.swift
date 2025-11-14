//
//  TestLimit.swift
//  MusadoraCLI
//
//  Created by Rudrank Riyam on 11/14/25.
//

import ArgumentParser
import Foundation
import MusadoraKit

@preconcurrency import MusicKit

@available(macOS 14.0, *)
struct TestLimit: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Test the maximum limit for library playlists API"
  )

  @Option(name: .shortAndLong, help: "Starting limit value to test")
  var start: Int = 100

  @Option(name: .shortAndLong, help: "Maximum limit value to test")
  var max: Int = 500

  @Option(name: [.customShort("i"), .long], help: "Increment step for each test")
  var increment: Int = 50

  mutating func run() async throws {
    print("Testing Library Playlists API Limits")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

    // Request music authorization
    let status = await MusicAuthorization.request()
    guard status == .authorized else {
      print("ERROR: Music authorization not granted")
      return
    }

    print("Authorization: OK\n")

    var currentLimit = start

    while currentLimit <= max {
      print("Testing limit: \(currentLimit)...", terminator: " ")
      fflush(stdout)

      do {
        var request = MusicLibraryRequest<Playlist>()
        request.limit = currentLimit

        let response = try await request.response()

        print("SUCCESS - Got \(response.items.count) playlists")

        // Print playlist details
        for (index, playlist) in response.items.enumerated() {
          print("  [\(index + 1)] \(playlist.name)")
        }

        currentLimit += increment
      } catch {
        print("FAILED")
        print("\nMaximum limit found: \(currentLimit - increment)")
        print("Error: \(error)")
        break
      }
    }

    if currentLimit > max {
      print("\nAll tests passed up to limit: \(max)")
      print("The API may support even higher limits!")
    }
  }
}
