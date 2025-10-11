//
//  CatalogStorefrontTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 25/03/23.
//

import Foundation
@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct CatalogStorefrontTests {
  @Test
  func decodingUSStorefront() throws {
    let jsonString = """
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
        """
    let jsonData = Data(jsonString.utf8)

    let storefront = try decodeSingleStorefront(from: jsonData)

    #expect(storefront.id == "us")
    #expect(storefront.type == .storefronts)
    #expect(storefront.supportedLanguageTags == ["en-US", "es-MX", "ar", "ru", "zh-Hans-CN", "fr-FR", "ko", "pt-BR", "vi", "zh-Hant-TW"])
    #expect(storefront.explicitContentPolicy == .allowed)
    #expect(storefront.name == "United States")
    #expect(storefront.defaultLanguageTag == "en-US")
    #expect(storefront.storefrontId == 143_441)
  }

  @Test
  func decodingINStorefront() throws {
    let jsonString = """
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
        """
    let jsonData = Data(jsonString.utf8)

    let storefront = try decodeSingleStorefront(from: jsonData)
    #expect(storefront.id == "in")
    #expect(storefront.type == .storefronts)
    #expect(storefront.supportedLanguageTags == ["en-GB", "hi"])
    #expect(storefront.explicitContentPolicy == .optIn)
    #expect(storefront.name == "India")
    #expect(storefront.defaultLanguageTag == "en-GB")
    #expect(storefront.storefrontId == 143_467)
  }

  @Test
  func decodingJPStorefront() throws {
    let jsonString = """
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
        """
    let jsonData = Data(jsonString.utf8)

    let storefront = try decodeSingleStorefront(from: jsonData)
    #expect(storefront.id == "jp")
    #expect(storefront.type == .storefronts)
    #expect(storefront.supportedLanguageTags == ["ja", "en-US"])
    #expect(storefront.explicitContentPolicy == .allowed)
    #expect(storefront.name == "Japan")
    #expect(storefront.defaultLanguageTag == "ja")
    #expect(storefront.storefrontId == 143_462)
  }

  @Test
  func decodingCNStorefront() throws {
    let jsonString = """
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
        """
    let jsonData = Data(jsonString.utf8)

    let storefront = try decodeSingleStorefront(from: jsonData)
    #expect(storefront.id == "cn")
    #expect(storefront.type == .storefronts)
    #expect(storefront.supportedLanguageTags == ["zh-Hans-CN", "en-GB"])
    #expect(storefront.explicitContentPolicy == .prohibited)
    #expect(storefront.name == "China")
    #expect(storefront.defaultLanguageTag == "zh-Hans-CN")
    #expect(storefront.storefrontId == 143_465)
  }

  @Test
  func decodingNonExistentStorefront() throws {
    let jsonString = """
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
        """
    let jsonData = Data(jsonString.utf8)

    let storefront = try decodeSingleStorefront(from: jsonData)
    #expect(storefront.id == "xx")
    #expect(storefront.type == .storefronts)
    #expect(storefront.storefrontId == nil)
  }

  private func decodeSingleStorefront(from data: Data) throws -> MStorefront {
    let decoder = JSONDecoder()
    let result = try decoder.decode(StorefrontsData.self, from: data)
    try #require(result.data.count == 1, "Expected a single storefront in the data array.")
    let storefront = try #require(result.data.first)
    return storefront
  }
}
