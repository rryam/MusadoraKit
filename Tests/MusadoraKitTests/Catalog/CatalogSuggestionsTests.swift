//
//  CatalogSuggestionsTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 22/03/23.
//

@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct CatalogSuggestionsTests {
  @Test
  func catalogSuggestionsEndpointWithKindsAndTerm() throws {
    let request = MusicCatalogSuggestionsRequest(term: "taylor", kinds: [.terms])
    let url = try request.endpointURL(storefront: "us")
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/catalog/us/search/suggestions?kinds=terms&term=taylor")
  }

  @Test
  func catalogSuggestionsEndpointWithEmptyKindsThrows() throws {
    let request = MusicCatalogSuggestionsRequest(term: "taylor", kinds: [])

    let error = #expect(throws: MusadoraKitError.self) {
      try request.endpointURL(storefront: "us")
    }

    #expect(error == MusadoraKitError.typeMissing)
  }

  @Test
  func catalogSuggestionsEndpointWithTopResultsWithoutValidTypesThrows() throws {
    let request = MusicCatalogSuggestionsRequest(term: "taylor", kinds: [.topResults], types: [])

    let error = #expect(throws: MusadoraKitError.self) {
      try request.endpointURL(storefront: "us")
    }

    #expect(error == MusadoraKitError.typeMissing)
  }
}
