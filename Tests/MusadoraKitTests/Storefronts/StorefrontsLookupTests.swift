import Foundation
import Testing
@testable import MusadoraKit

@Suite struct StorefrontsLookupTests {

  @Test func storefrontResourceIncludesKnownIdentifiers() {
    let expected: [(String, Int)] = [
      ("us", 143441),
      ("JP", 143462),
      ("ca", 143455),
      ("gb", 143444),
      ("de", 143443),
      ("au", 143460),
      ("in", 143467),
      ("sa", 143479),
      ("za", 143472),
      ("br", 143503),
      ("cn", 143465)
    ]

    for (code, storefrontId) in expected {
      #expect(MStorefront.storefrontID(forCountryCode: code) == storefrontId)
    }
  }

  @Test func storefrontLookupMissingCodeReturnsNil() {
    #expect(MStorefront.storefrontID(forCountryCode: "zz") == nil)
  }

  @Test func invalidStorefrontResourceThrows() {
    let invalidJSON = Data(#"{"code": "xx"}"#.utf8)
    #expect(throws: Error.self) {
      _ = try MStorefront.decodeStorefrontLookup(from: invalidJSON)
    }
  }

  @Test func corruptStorefrontResourceYieldsEmptyLookup() {
    let corruptJSON = Data(#"[{"code": 42, "storefrontId": "invalid"}]"#.utf8)
    let lookup = MStorefront.loadStorefrontLookup(from: corruptJSON)
    #expect(lookup.isEmpty)
  }

  @Test func decodeStorefrontLookupNormalizesCodes() throws {
    let json = Data(#"[{"code":"US","storefrontId":143441}]"#.utf8)
    let lookup = try MStorefront.decodeStorefrontLookup(from: json)
    #expect(lookup["us"] == 143441)
  }
}
