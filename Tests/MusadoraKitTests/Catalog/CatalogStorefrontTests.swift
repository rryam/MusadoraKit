//
//  CatalogStorefrontTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 25/03/23.
//

import Foundation

@testable import MusadoraKit
import MusicKit
import XCTest

final class CatalogStorefrontTests: XCTestCase {
  func testDecodingForUSStorefront() throws {
    let jsonData = """
              {
                  "data": [
                      {
                          "id": "us",
                          "type": "storefronts",
                          "href": "/v1/storefronts/us",
                          "attributes": {
                              "supportedLanguageTags": [
                                  "en-US",
                                  "es-MX",
                                  "ar",
                                  "ru",
                                  "zh-Hans-CN",
                                  "fr-FR",
                                  "ko",
                                  "pt-BR",
                                  "vi",
                                  "zh-Hant-TW"
                              ],
                              "explicitContentPolicy": "allowed",
                              "name": "United States",
                              "defaultLanguageTag": "en-US"
                          }
                      }
                  ]
              }
              """.data(using: .utf8)!

    let decoder = JSONDecoder()
    let result = try decoder.decode(StorefrontsData.self, from: jsonData)

    XCTAssertEqual(result.data.count, 1)
    let storefront = result.data[0]

    XCTAssertEqual(storefront.id, "us")
    XCTAssertEqual(storefront.type, .storefronts)
    XCTAssertEqual(storefront.supportedLanguageTags, ["en-US", "es-MX", "ar", "ru", "zh-Hans-CN", "fr-FR", "ko", "pt-BR", "vi", "zh-Hant-TW"])
    XCTAssertEqual(storefront.explicitContentPolicy, .allowed)
    XCTAssertEqual(storefront.name, "United States")
    XCTAssertEqual(storefront.defaultLanguageTag, "en-US")
  }

  func testDecodingForINStorefront() throws {
    let jsonData = """
           {
               "data": [
                   {
                       "id": "in",
                       "type": "storefronts",
                       "href": "/v1/storefronts/in",
                       "attributes": {
                           "supportedLanguageTags": [
                               "en-GB",
                               "hi"
                           ],
                           "explicitContentPolicy": "opt-in",
                           "name": "India",
                           "defaultLanguageTag": "en-GB"
                       }
                   }
               ]
           }
           """.data(using: .utf8)!

    let decoder = JSONDecoder()
    let result = try decoder.decode(StorefrontsData.self, from: jsonData)

    XCTAssertEqual(result.data.count, 1)
    let storefront = result.data[0]
    XCTAssertEqual(storefront.id, "in")
    XCTAssertEqual(storefront.type, .storefronts)
    XCTAssertEqual(storefront.supportedLanguageTags, ["en-GB", "hi"])
    XCTAssertEqual(storefront.explicitContentPolicy, .optIn)
    XCTAssertEqual(storefront.name, "India")
    XCTAssertEqual(storefront.defaultLanguageTag, "en-GB")
  }
}
