import Testing
@testable import MusadoraKit

@Suite struct StorefrontsEndpointTests {

  @Test func storefrontsCollectionEndpoint() throws {
    let url = try MCatalog.storefrontsURL()
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/storefronts")
  }

  @Test func storefrontDetailEndpointForIdentifier() throws {
    let url = try MCatalog.storefrontsURL(id: "jp")
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/storefronts/jp")
  }
}
