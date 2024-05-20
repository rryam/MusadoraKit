//
//  "That romantic artist soul is a lie,
//  A mask I wear, with a tear in my eye"
//
//  HundredBestAlbumRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 19/05/24.
//

import Foundation

struct HundredBestAlbumRequest {
  private let position: Int

  init(position: Int) {
    self.position = position
  }

  func response() async throws -> HundredBestAlbum {
    let url = try albumEndpointURL
    return try await fetchAlbum(from: url)
  }

  private func fetchAlbum(from url: URL) async throws -> HundredBestAlbum {
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(HundredBestAlbum.self, from: data)
  }
}

extension HundredBestAlbumRequest {
  internal var albumEndpointURL: URL {
    get throws {
      var components = URLComponents()
      components.scheme = "https"
      components.host = "100best.music.apple.com"
      components.path = "/content/us/en-us/\(position).json"

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      return url
    }
  }
}
