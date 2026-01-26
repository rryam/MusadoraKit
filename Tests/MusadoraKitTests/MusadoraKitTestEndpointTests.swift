import Foundation
@testable import MusadoraKit
import Testing

private struct BadURLMusicComponents: MusicURLComponents {
  var queryItems: [URLQueryItem]?
  var path: String = ""

  var url: URL? {
    nil
  }
}

@Suite
struct MusadoraKitTestEndpointTests {
  @Test
  func testEndpointURLBuilds() throws {
    let url = try MusadoraKit.testEndpointURL()
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/test")
  }

  @Test
  func testEndpointURLWithBadComponentsThrows() throws {
    let error = #expect(throws: URLError.self) {
      try MusadoraKit.testEndpointURL(components: BadURLMusicComponents())
    }

    #expect(error == URLError(.badURL))
  }
}
