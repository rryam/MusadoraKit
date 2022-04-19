//
//  AlbumsEndpointTests.swift
//  AlbumsEndpointTests
//
//  Created by Rudrank Riyam on 18/04/22.
//

import XCTest
@testable import MusadoraLabsKit

final class AlbumsEndpointTests: XCTestCase {
    // MARK: - Catalog Albums Tests
    func testFetchACatalogAlbumByIDEndpoint() async throws {
        let id = "1564530719"
        let endpoint = try await MusadoraLabsKit.catalogAlbum(id: id, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/albums/1564530719")
    }

    func testFetchMultipleCatalogAlbumsByIDsEndpoint() async throws {
        let ids = ["1564530719", "1568819304"]
        let endpoint = try await MusadoraLabsKit.catalogAlbums(ids: ids, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/albums?ids=1564530719,1568819304")
    }

    func testFetchMultipleCatalogAlbumsByUPCEndpoint() async throws {
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
