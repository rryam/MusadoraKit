import Foundation
import Testing
import MusicKit
@testable import MusadoraKit

@Suite struct MusicLibraryResourcesEndpointTests {

  @Test func libraryResourcesEndpointBuildsQueryPerType() throws {
    let request = MusicLibraryResourcesRequest(types: [
      .songs: [MusicItemID("1"), MusicItemID("2")],
      .albums: [MusicItemID("3")]
    ])

    let url = try request.makeEndpointURL()
    #expect(url.absoluteString.starts(with: "https://api.music.apple.com/v1/me/library"))

    let items = try queryItems(from: url)
    #expect(items["ids[library-songs]"] == "1,2")
    #expect(items["ids[library-albums]"] == "3")
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
