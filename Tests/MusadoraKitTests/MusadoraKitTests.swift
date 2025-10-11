//
//  MusadoraKitTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation
@testable import MusadoraKit
import Testing

@Suite struct MusadoraKitTests {}

public func expectEndpoint(_ endpoint: URL, equals urlString: String, sourceLocation: SourceLocation = #_sourceLocation) {
  guard let expected = URL(string: urlString) else {
    Issue.record("Failed to create URL from string '\(urlString)'", sourceLocation: sourceLocation)
    return
  }

  #expect(endpoint == expected, sourceLocation: sourceLocation)
}
