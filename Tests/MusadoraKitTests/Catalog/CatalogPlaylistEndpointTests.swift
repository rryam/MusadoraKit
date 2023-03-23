//
//  CatalogPlaylistEndpointTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 20/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

struct BadURLAppleMusicURLComponents: MURLComponents {
  var path: String = ""
  var queryItems: [URLQueryItem]?

  var url: URL? {
    return nil
  }
}

final class CatalogPlaylistEndpointTests: XCTestCase {
  func testChartPlaylistsURLWithoutStorefront() throws {
    let currentStorefront = "in"
    let url = "https://api.music.apple.com/v1/catalog/in/playlists?filter%5Bstorefront-chart%5D=in"
    let endpointURL = try MCatalog.chartPlaylistsURL(currentStorefront: currentStorefront)

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testChartPlaylistsURLWithStorefront() throws {
    let currentStorefront = "in"
    let targetStorefront = "ca"
    let url = "https://api.music.apple.com/v1/catalog/in/playlists?filter%5Bstorefront-chart%5D=ca"
    let endpointURL = try MCatalog.chartPlaylistsURL(currentStorefront: currentStorefront, targetStorefront: targetStorefront)

    XCTAssertEqualEndpoint(endpointURL, url)
  }

  func testChartPlaylistsURLWithBadURL() throws {
    let currentStorefront = "in"
    let components = BadURLAppleMusicURLComponents()

    XCTAssertThrowsError(try MCatalog.chartPlaylistsURL(currentStorefront: currentStorefront, components: components)) { error in
      XCTAssertEqual(error as? URLError, URLError(.badURL))
    }
  }
}
