@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct MHistoryRecentlyPlayedRequestTests {
  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  @Test
  func recentlyPlayedContainerRequestSetsLimit() {
    let request = MHistory.recentlyPlayedContainerRequest(limit: 25)
    #expect(request.limit == 25)
  }

  @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
  @Test
  func recentlyPlayedSongsRequestSetsLimit() {
    let request = MHistory.recentlyPlayedSongsRequest(limit: 10)
    #expect(request.limit == 10)
  }

  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, *)
  @Test
  func mostPlayedSongsRequestSetsLimit() {
    let request = MHistory.mostPlayedSongsRequest(limit: 100)
    #expect(request.limit == 100)
  }
}
