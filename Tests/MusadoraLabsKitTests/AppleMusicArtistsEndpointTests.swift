//
//  AppleMusicArtistsEndpointTests.swift
//  AppleMusicArtistsEndpointTests
//
//  Created by Rudrank Riyam on 19/04/22.
//

import XCTest
@testable import MusadoraLabsKit

class AppleMusicArtistsEndpointTests: XCTestCase {
    // MARK: - Catalog Artists Tests
    func testFetchACatalogArtistsByIDEndpoint() async throws {
        let id = "1264549322"
        let endpoint = try await MusadoraLabsKit.catalogArtist(id: id, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/artists/1264549322")
    }

    func testFetchMultipleCatalogArtistsByIDsEndpoint() async throws {
        let ids = ["1065981054", "1264549322"]
        let endpoint = try await MusadoraLabsKit.catalogArtists(ids: ids, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/artists?ids=1065981054,1264549322")
    }

    // MARK: - Library Artists Tests
    func testFetchALibraryArtistByIDEndpoint() async throws {
        let id = "r.V2zewCs"
        let endpoint = try await MusadoraLabsKit.libraryArtist(id: id)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/artists/r.V2zewCs")
    }

    func testFetchMultipleLibraryArtistsByIDsEndpoint() async throws {
        let ids = ["r.V2zewCs"]
        let endpoint = try await MusadoraLabsKit.libraryArtists(ids: ids)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/artists?ids=r.V2zewCs")
    }

    func testFetchAllLibraryArtistsEndpoint() async throws {
        let endpoint = try await MusadoraLabsKit.libraryArtists()
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/artists")
    }
}
