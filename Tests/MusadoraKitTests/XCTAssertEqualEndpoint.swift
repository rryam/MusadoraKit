//
//  XCTAssertEqualEndpoint.swift
//  
//
//  Created by Rudrank Riyam on 19/04/22.
//

import XCTest

public func XCTAssertEqualEndpoint(_ endpoint: URL, _ url: String) {
    let url = URL(string: url)!
    XCTAssertEqual(endpoint, url)
}
