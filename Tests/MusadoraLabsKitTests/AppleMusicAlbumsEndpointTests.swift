//
//  AppleMusicAlbumsEndpointTests.swift
//  AppleMusicAlbumsEndpointTests
//
//  Created by Rudrank Riyam on 18/04/22.
//

import XCTest
@testable import MusadoraLabsKit

final class AppleMusicAlbumsEndpointTests: XCTestCase {
    // MARK: - Catalog Albums Tests
    func testFetchACatalogAlbumByIDEndpoint() async throws {
        let id = "1456313174"
        let endpoint = try await MusadoraLabsKit.catalogAlbum(id: id, storeFront: "in")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/in/albums/1456313174")
    }

    func testFetchMultipleCatalogAlbumsByIDsEndpoint() async throws {
        let ids = ["1456313174", "1468166325"]
        let endpoint = try await MusadoraLabsKit.catalogAlbums(ids: ids, storeFront: "in")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/in/albums?ids=1456313174,1468166325")
    }

    func testFetchMultipleCatalogByUPCEndpoint() async throws {
        let upcs = ["5056167160984"]
        let endpoint = try await MusadoraLabsKit.catalogAlbums(upcs: upcs, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/albums?filter[upc]=5056167160984")
    }

    // MARK: - Library Albums Tests
    func testFetchALibraryAlbumByIDEndpoint() async throws {
        let id = "l.qrRWYhq"
        let endpoint = try await MusadoraLabsKit.libraryAlbum(id: id)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/albums/l.qrRWYhq")
    }

    func testFetchMultipleLibraryAlbumsByIDsEndpoint() async throws {
        let ids = ["l.qrRWYhq"]
        let endpoint = try await MusadoraLabsKit.libraryAlbums(ids: ids)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/albums?ids=l.qrRWYhq")
    }

    func testFetchAllLibraryAlbumsEndpoint() async throws {
        let endpoint = try await MusadoraLabsKit.libraryAlbums()
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/albums")
    }
}
