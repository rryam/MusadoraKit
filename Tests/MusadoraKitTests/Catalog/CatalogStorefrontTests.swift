//
//  CatalogStorefrontTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 25/03/23.
//

import XCTest
@testable import MusadoraKit
import MusicKit

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
    XCTAssertEqual(storefront.storefrontId, 143441, "US storefront ID should be 143441")
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
    XCTAssertEqual(storefront.storefrontId, 143467, "India storefront ID should be 143467")
  }
  
  func testDecodingForJPStorefront() throws {
    let jsonData = """
        {
            "data": [
                {
                    "id": "jp",
                    "type": "storefronts",
                    "href": "/v1/storefronts/jp",
                    "attributes": {
                        "supportedLanguageTags": [
                            "ja",
                            "en-US"
                        ],
                        "explicitContentPolicy": "allowed",
                        "name": "Japan",
                        "defaultLanguageTag": "ja"
                    }
                }
            ]
        }
        """.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let result = try decoder.decode(StorefrontsData.self, from: jsonData)
    
    XCTAssertEqual(result.data.count, 1)
    let storefront = result.data[0]
    XCTAssertEqual(storefront.id, "jp")
    XCTAssertEqual(storefront.type, .storefronts)
    XCTAssertEqual(storefront.supportedLanguageTags, ["ja", "en-US"])
    XCTAssertEqual(storefront.explicitContentPolicy, .allowed)
    XCTAssertEqual(storefront.name, "Japan")
    XCTAssertEqual(storefront.defaultLanguageTag, "ja")
    XCTAssertEqual(storefront.storefrontId, 143462, "Japan storefront ID should be 143462")
  }
  
  func testDecodingForCNStorefront() throws {
    let jsonData = """
        {
            "data": [
                {
                    "id": "cn",
                    "type": "storefronts",
                    "href": "/v1/storefronts/cn",
                    "attributes": {
                        "supportedLanguageTags": [
                            "zh-Hans-CN",
                            "en-GB"
                        ],
                        "explicitContentPolicy": "prohibited",
                        "name": "China",
                        "defaultLanguageTag": "zh-Hans-CN"
                    }
                }
            ]
        }
        """.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let result = try decoder.decode(StorefrontsData.self, from: jsonData)
    
    XCTAssertEqual(result.data.count, 1)
    let storefront = result.data[0]
    XCTAssertEqual(storefront.id, "cn")
    XCTAssertEqual(storefront.type, .storefronts)
    XCTAssertEqual(storefront.supportedLanguageTags, ["zh-Hans-CN", "en-GB"])
    XCTAssertEqual(storefront.explicitContentPolicy, .prohibited)
    XCTAssertEqual(storefront.name, "China")
    XCTAssertEqual(storefront.defaultLanguageTag, "zh-Hans-CN")
    XCTAssertEqual(storefront.storefrontId, 143465, "China storefront ID should be 143465")
  }
  
  func testDecodingForNonExistentStorefront() throws {
    let jsonData = """
        {
            "data": [
                {
                    "id": "xx",
                    "type": "storefronts",
                    "href": "/v1/storefronts/xx",
                    "attributes": {
                        "supportedLanguageTags": [
                            "en-US"
                        ],
                        "explicitContentPolicy": "allowed",
                        "name": "Non-existent Country",
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
    XCTAssertEqual(storefront.id, "xx")
    XCTAssertEqual(storefront.type, .storefronts)
    XCTAssertNil(storefront.storefrontId, "Non-existent storefront should have nil storefrontId")
  }
}
