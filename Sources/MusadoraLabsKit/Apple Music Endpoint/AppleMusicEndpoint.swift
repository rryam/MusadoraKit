//
//  MusadoraLabsKit.swift
//  MusadoraLabsKit
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation
import MusicKit

extension MusadoraLabsKit {
  var url: URL {
    get async throws {
      var components = URLComponents()
      components.scheme = "https"
      components.host = "api.music.apple.com"
      components.path = library.path

      if let queryItems = queryItems {
        components.queryItems = queryItems
      }

      switch library {
      case .catalog:
        if let storeFront = storeFront {
          components.path += storeFront + "/" + path
        } else {
          let storeFront = try await MusicDataRequest.currentCountryCode
          components.path += storeFront + "/" + path
        }
      case .user, .library: components.path += path
      }

      guard let url = components.url else {
        preconditionFailure("Invalid URL components: \(components)")
      }
      return url
    }
  }
}
