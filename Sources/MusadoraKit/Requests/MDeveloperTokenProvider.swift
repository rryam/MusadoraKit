//
//  MDeveloperTokenProvider.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 15/03/23.
//

import Foundation

/// A class that implements the `MusicTokenProvider` protocol for providing **custom** developer tokens in the Apple Music API.
class MDeveloperTokenProvider: MusicTokenProvider, @unchecked Sendable {

  /// The  **custom** developer token used for API requests.
  private var developerToken: String = ""

  /// Initializes a new `MDeveloperTokenProvider` instance with the given **custom** developer token.
  ///
  /// - Parameter developerToken: The **custom** developer token to use for API requests.
  convenience init(developerToken: String) {
    self.init()
    self.developerToken = developerToken
  }

  /// Provides the **custom** developer token for API requests.
  ///
  /// - Parameter options: The options for the token request. Unused in this implementation.
  /// - Returns: The **custom** developer token as a string.
  public func developerToken(options: MusicTokenRequestOptions) async throws -> String {
    developerToken
  }
}
