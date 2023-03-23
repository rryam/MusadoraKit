//
//  CatalogSearchTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 23/03/23.
//

import Foundation
@testable import MusadoraKit
import MusicKit
import XCTest

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
class CatalogSearchTests: XCTestCase {
  func testSearchTypesAll() {
    let allTypes = MCatalogSearchTypes.all

    XCTAssertTrue(allTypes.contains(.songs))
    XCTAssertTrue(allTypes.contains(.albums))
    XCTAssertTrue(allTypes.contains(.playlists))
    XCTAssertTrue(allTypes.contains(.artists))
    XCTAssertTrue(allTypes.contains(.stations))
    XCTAssertTrue(allTypes.contains(.recordLabels))

    XCTAssertTrue(allTypes.contains(.musicVideos))
    XCTAssertTrue(allTypes.contains(.curators))
    XCTAssertTrue(allTypes.contains(.radioShows))
  }
}
