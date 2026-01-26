@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct MRecommendationPersonalTests {
  @Test
  func personalRecommendationsRequestSetsLimit() {
    let request = MRecommendation.personalRecommendationsRequest(limit: 12)
    #expect(request.limit == 12)
  }

  @Test
  func personalRecommendationsRequestAllowsNilLimit() {
    let request = MRecommendation.personalRecommendationsRequest(limit: nil)
    #expect(request.limit == nil)
  }
}
