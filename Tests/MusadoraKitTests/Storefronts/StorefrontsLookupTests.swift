import Foundation
@testable import MusadoraKit
import Testing

@Suite
struct StorefrontsLookupTests {
  @Test
  func storefrontResourceIncludesKnownIdentifiers() {
    let expected: [(String, Int)] = [
      ("us", 143_441),
      ("JP", 143_462),
      ("ca", 143_455),
      ("gb", 143_444),
      ("de", 143_443),
      ("au", 143_460),
      ("in", 143_467),
      ("sa", 143_479),
      ("za", 143_472),
      ("br", 143_503),
      ("cn", 143_465)
    ]

    for (code, storefrontId) in expected {
      #expect(MusicStorefront.storefrontID(forCountryCode: code) == storefrontId)
    }
  }

  @Test
  func storefrontLookupMissingCodeReturnsNil() {
    #expect(MusicStorefront.storefrontID(forCountryCode: "zz") == nil)
  }

  @Test
  func invalidStorefrontResourceThrows() {
    let invalidJSON = Data(#"{"code": "xx"}"#.utf8)
    #expect(throws: Error.self) {
      _ = try MusicStorefront.decodeStorefrontLookup(from: invalidJSON)
    }
  }

  @Test
  func corruptStorefrontResourceYieldsEmptyLookup() {
    let corruptJSON = Data(#"[{"code": 42, "storefrontId": "invalid"}]"#.utf8)
    let lookup = MusicStorefront.loadStorefrontLookup(from: corruptJSON)
    #expect(lookup.isEmpty)
  }

  @Test
  func decodeStorefrontLookupNormalizesCodes() throws {
    let json = Data(#"[{"code":"US","storefrontId":143441}]"#.utf8)
    let lookup = try MusicStorefront.decodeStorefrontLookup(from: json)
    #expect(lookup["us"] == 143_441)
  }
}
