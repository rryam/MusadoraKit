//
//  MusicCatalogRatingAddRequestTests.swift
//  MusicCatalogRatingAddRequestTests
//
//  Created by Rudrank Riyam on 17/07/22.
//

import XCTest
import MusicKit
@testable import MusadoraKit

final class MusicCatalogRatingAddRequestTests: XCTestCase {
  func testAddPersonalAlbumRatingEndpointURL() throws {
    let id: MusicItemID = "1138988512"
    let request = MusicCatalogRatingRequest<Album>(matching: \.id, equalTo: id)
    let url = try request.catalogRatingsEndpointURL
    XCTAssertEqualEndpoint(url, "https://api.music.apple.com/v1/me/ratings/albums?ids=1138988512")
  }
}
