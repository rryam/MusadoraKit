//
//  CatalogSearchTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 23/03/23.
//

import Foundation
import Testing
import MusicKit
@testable import MusadoraKit

@Suite struct CatalogSearchTests {

  @Test func searchTypesIncludeAllResources() {
    guard #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *) else {
      Issue.record("Catalog search types require iOS 15.4/macOS 12.3/watchOS 9.0/tvOS 15.4 or newer")
      return
    }

    let allTypes = MCatalogSearchTypes.all

    #expect(allTypes.contains(.songs))
    #expect(allTypes.contains(.albums))
    #expect(allTypes.contains(.playlists))
    #expect(allTypes.contains(.artists))
    #expect(allTypes.contains(.stations))
    #expect(allTypes.contains(.recordLabels))

    #expect(allTypes.contains(.musicVideos))
    #expect(allTypes.contains(.curators))
    #expect(allTypes.contains(.radioShows))
  }
}
