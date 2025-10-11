//
//  EquivalentItemsEndpointTests.swift
//  MusadoraKitTest
//
//  Created by Rudrank Riyam on 20/03/23.
//

import Foundation
@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct EquivalentItemsEndpointTests {
  @Test
  func cleanEquivalentEndpointURL() throws {
    let storefront = "in"
    let song = try Song.mock
    let endpointURL = try song.cleanEquivalentURL(storefront: storefront, path: .songs)
    let url = "https://api.music.apple.com/v1/catalog/in/songs?filter%5Bequivalents%5D=1640832991&restrict=explicit"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func cleanEquivalentsEndpointURL() throws {
    let storefront = "in"
    let songs = try Song.mocks
    let endpointURL = try songs.cleanEquivalentsURL(storefront: storefront, path: .songs)
    let url = "https://api.music.apple.com/v1/catalog/in/songs?filter%5Bequivalents%5D=1640832991,1492318640&restrict=explicit"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func equivalentEndpointURL() throws {
    let storefront = "tw"
    let song = try Song.mock
    let endpointURL = try song.equivalentURL(storefront: storefront, path: .songs)
    let url = "https://api.music.apple.com/v1/catalog/tw/songs?filter%5Bequivalents%5D=1640832991"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func equivalentsEndpointURL() throws {
    let storefront = "tw"
    let songs = try Song.mocks
    let endpointURL = try songs.equivalentsURL(storefront: storefront, path: .songs)
    let url = "https://api.music.apple.com/v1/catalog/tw/songs?filter%5Bequivalents%5D=1640832991,1492318640"

    expectEndpoint(endpointURL, equals: url)
  }

  @Test
  func catalogEquivalentEndpointURL() throws {
    let storefront = "jp"
    let id = MusicItemID("1640832991")
    let endpointURL = try MCatalog.equivalentEndpointURL(id: id, targetStorefront: storefront, type: Song.self)
    let url = "https://api.music.apple.com/v1/catalog/jp/songs?filter%5Bequivalents%5D=1640832991"

    expectEndpoint(endpointURL, equals: url)
  }
}
