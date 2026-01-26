import Foundation
@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct MusicCatalogResourcesEndpointTests {
  @Test
  func catalogResourcesEndpointBuildsQueryPerType() throws {
    let request = MusicCatalogResourcesRequest(types: [
      .songs: [MusicItemID("1"), MusicItemID("2")],
      .albums: [MusicItemID("3")]
    ])

    let url = try request.endpointURL(storefront: "us")
    #expect(url.absoluteString.starts(with: "https://api.music.apple.com/v1/catalog/us"))

    let items = try queryItems(from: url)
    #expect(items["ids[songs]"] == "1,2")
    #expect(items["ids[albums]"] == "3")
  }

  @Test
  func catalogResourcesEndpointWithEmptyTypesThrows() throws {
    let request = MusicCatalogResourcesRequest(types: [:])

    let error = #expect(throws: MusadoraKitError.self) {
      try request.endpointURL(storefront: "us")
    }

    #expect(error == MusadoraKitError.idMissing)
  }

  @Test
  func catalogResourcesEndpointWithEmptyIdsThrows() throws {
    let request = MusicCatalogResourcesRequest(types: [
      .songs: []
    ])

    let error = #expect(throws: MusadoraKitError.self) {
      try request.endpointURL(storefront: "us")
    }

    #expect(error == MusadoraKitError.idMissing)
  }

  private func queryItems(from url: URL) throws -> [String: String] {
    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
          let queryItems = components.queryItems else {
      throw URLError(.badURL)
    }

    return queryItems.reduce(into: [:]) { result, item in
      result[item.name] = item.value
    }
  }
}
