//
//  MusadoraKitTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 19/04/22.
//

@testable import MusadoraKit
import XCTest

final class MusadoraKitTests: XCTestCase {}

public func XCTAssertEqualEndpoint(_ endpoint: URL, _ url: String) {
  let url = URL(string: url)!
  XCTAssertEqual(endpoint, url)
}
