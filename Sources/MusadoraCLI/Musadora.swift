//
//  Musadora.swift
//  MusadoraCLI
//
//  Created by Rudrank Riyam on 11/14/25.
//

import ArgumentParser
import Foundation
import MusadoraKit

@main
@available(macOS 14.0, *)
struct Musadora: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "musadora",
    abstract: "A command-line tool for interacting with Apple Music API via MusadoraKit",
    version: "1.0.0",
    subcommands: [
      Token.self,
      TestLimit.self
    ]
  )
}
