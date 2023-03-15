//
//  MDeveloperTokenProvider.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 15/03/23.
//

import Foundation

class MDeveloperTokenProvider: MusicTokenProvider, @unchecked Sendable {
  private var developerToken: String = ""

  convenience init(developerToken: String) {
    self.init()
    self.developerToken = developerToken
  }

  public func developerToken(options: MusicTokenRequestOptions) async throws -> String {
    developerToken
  }
}
