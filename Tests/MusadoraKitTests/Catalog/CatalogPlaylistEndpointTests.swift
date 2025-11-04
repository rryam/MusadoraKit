//
//  CatalogPlaylistEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 20/03/23.
//

import Foundation
@testable import MusadoraKit
import MusicKit
import Testing

struct BadURLAppleMusicURLComponents: MusicURLComponents {
  var path: String = ""
  var queryItems: [URLQueryItem]?

  var url: URL? {
    return nil
  }
}

@Suite
struct CatalogPlaylistEndpointTests {
  @Test
  func chartPlaylistsURLWithoutTargetStorefront() throws {
    let currentStorefront = "in"
    let url = "https://api.music.apple.com/v1/catalog/in/playlists?filter%5Bstorefront-chart%5D=in"
    let endpointURL = try MCatalog.chartPlaylistsURL(currentStorefront: currentStorefront)

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func chartPlaylistsURLWithTargetStorefront() throws {
    let currentStorefront = "in"
    let targetStorefront = "ca"
    let url = "https://api.music.apple.com/v1/catalog/in/playlists?filter%5Bstorefront-chart%5D=ca"
    let endpointURL = try MCatalog.chartPlaylistsURL(currentStorefront: currentStorefront, targetStorefront: targetStorefront)

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func chartPlaylistsURLWithBadComponentsThrows() {
    let currentStorefront = "in"
    let components = BadURLAppleMusicURLComponents()

    let error = #expect(throws: URLError.self) {
      try MCatalog.chartPlaylistsURL(currentStorefront: currentStorefront, components: components)
    }

    #expect(error == URLError(.badURL))
  }
}
