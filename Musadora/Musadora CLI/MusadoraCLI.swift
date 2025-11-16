//
//  MusadoraCLI.swift
//  Musadora CLI
//
//  Created by Rudrank Riyam on 11/14/25.
//

import Foundation
import ArgumentParser
import MusadoraKit

@preconcurrency import MusicKit

@main
struct MusadoraCLI: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "musadora",
    abstract: "Musadora CLI - Token Information and Testing",
    version: "1.0.0",
    subcommands: [TokenCommand.self, TestCommand.self]
  )

  func run() async throws {
    throw CleanExit.helpRequest(self)
  }
}

struct TokenCommand: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "token",
    abstract: "Display MusicKit tokens"
  )

  @Flag(name: .shortAndLong, help: "Show developer token only")
  var developerTokenOnly = false

  @Flag(name: .shortAndLong, help: "Show user token only")
  var userTokenOnly = false

  func run() async throws {
    // Flush output immediately
    fflush(stdout)
    
    print("Musadora CLI - Token Information")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("")
    fflush(stdout)
    
    print("Requesting Music authorization...")
    fflush(stdout)
    
    let status = await MusicAuthorization.request()
    
    print("Authorization status: \(status)")
    fflush(stdout)
    
    guard status == .authorized else {
      print("ERROR: Music authorization not granted. Status: \(status)")
      fflush(stdout)
      throw ValidationError("Music authorization not granted")
    }

    print("✓ Authorization: OK")
    print("")
    fflush(stdout)

    do {
      let developerToken = try await MusicDataRequest.tokenProvider.developerToken(options: .ignoreCache)
      
      if !userTokenOnly {
        print("Fetching developer token...")
        print("✓ Developer Token:")
        print(developerToken)
        print("")
      }

      if !developerTokenOnly {
        print("Fetching user token...")
        let userToken = try await MusicDataRequest.tokenProvider.userToken(for: developerToken, options: .ignoreCache)
        print("✓ User Token:")
        print(userToken)
        print("")
      }

      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
      print("Success! Tokens retrieved successfully.")
      fflush(stdout)
    } catch {
      print("ERROR getting tokens: \(error)")
      print("Error details: \(error.localizedDescription)")
      fflush(stdout)
      throw CleanExit.message("ERROR getting tokens: \(error.localizedDescription)")
    }
  }
}

struct TestCommand: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "test",
    abstract: "Test MusadoraKit functionality"
  )

  @Option(name: .shortAndLong, help: "Test type: 'recently-played-songs'")
  var type: String?

  @Option(name: .shortAndLong, help: "Limit for the request")
  var limit: Int?

  func run() async throws {
    fflush(stdout)

    print("Musadora CLI - Testing")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("")
    fflush(stdout)

    print("Requesting Music authorization...")
    fflush(stdout)

    let status = await MusicAuthorization.request()

    print("Authorization status: \(status)")
    fflush(stdout)

    guard status == .authorized else {
      print("ERROR: Music authorization not granted. Status: \(status)")
      fflush(stdout)
      throw ValidationError("Music authorization not granted")
    }

    print("✓ Authorization: OK")
    print("")
    fflush(stdout)

    do {
      let testType = type ?? "recently-played-songs"
      
      switch testType {
      case "recently-played-songs":
        print("Testing MHistory.recentlyPlayedSongs(limit: \(limit?.description ?? "nil"))...")
        fflush(stdout)
        
        let songs = try await MHistory.recentlyPlayedSongs(limit: limit)
        
        print("✓ Success! Retrieved \(songs.count) song(s)")
        print("")
        
        for (index, song) in songs.enumerated() {
          print("\(index + 1). \(song.title) - \(song.artistName)")
        }
        
      default:
        throw ValidationError("Unknown test type: \(testType). Use 'recently-played-songs'")
      }

      print("")
      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
      print("Test completed successfully!")
      fflush(stdout)
    } catch {
      print("ERROR during test: \(error)")
      print("Error details: \(error.localizedDescription)")
      fflush(stdout)
      throw CleanExit.message("ERROR during test: \(error.localizedDescription)")
    }
  }
}
