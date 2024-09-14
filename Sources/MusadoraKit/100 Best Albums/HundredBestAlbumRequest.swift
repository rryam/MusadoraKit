//
//  HundredBestAlbumRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 19/05/24.
//

import Foundation

public struct HundredBestAlbumRequest {
  private let position: Int
  private let storefront: String
  private let region: String

  public init(position: Int, storefront: String = "us", region: String = "en-us") {
    self.position = position
    self.storefront = storefront
    self.region = region
  }

  public func response() async throws -> HundredBestAlbum {
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
      components.path = "/content/\(storefront)/\(region)/\(position).json"

      guard let url = components.url else {
        throw URLError(.badURL)
      }

      return url
    }
  }
}
