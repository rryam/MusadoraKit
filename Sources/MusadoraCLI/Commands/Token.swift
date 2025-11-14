//
//  Token.swift
//  MusadoraCLI
//
//  Created by Rudrank Riyam on 11/14/25.
//

import ArgumentParser
import Foundation
import MusadoraKit

struct Token: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Display information about an Apple Music developer token"
  )

  @Argument(help: "The developer token (JWT) to analyze")
  var token: String

  mutating func run() throws {
    print("Developer Token Information")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

    print("Token:")
    print(token)

    print("\nToken Length: \(token.count) characters")

    // Try to decode JWT parts
    let parts = token.split(separator: ".")
    if parts.count == 3 {
      print("JWT Structure: Valid (3 parts: header.payload.signature)")
      print("Header length: \(parts[0].count)")
      print("Payload length: \(parts[1].count)")
      print("Signature length: \(parts[2].count)")
    } else {
      print("JWT Structure: Invalid (expected 3 parts, got \(parts.count))")
    }
  }
}
