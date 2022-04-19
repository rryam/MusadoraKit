//
//  SongsEndpointTests.swift
//  SongsEndpointTests
//
//  Created by Rudrank Riyam on 19/04/22.
//

import XCTest
@testable import MusadoraLabsKit

class SongsEndpointTests: XCTestCase {
    // MARK: - Catalog Songs Tests
    func testFetchACatalogSongsByIDEndpoint() async throws {
        let id = "1560735548"
        let endpoint = try await MusadoraLabsKit.catalogSong(id: id, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/songs/1560735548")
    }

    func testFetchMultipleCatalogSongsByIDsEndpoint() async throws {
        let ids = ["1560735548", "1572278914"]
        let endpoint = try await MusadoraLabsKit.catalogSongs(ids: ids, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/songs?ids=1560735548,1572278914")
    }

    func testFetchMultipleCatalogByISRCEndpoint() async throws {
        let isrcs = ["USUM72105936"]
        let endpoint = try await MusadoraLabsKit.catalogSongs(isrcs: isrcs, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/songs?filter[isrc]=USUM72105936")
    }

    // MARK: - Library Songs Tests
    func testFetchALibrarySongByIDEndpoint() async throws {
        let id = "i.gelNOzPuL41Lxo"
        let endpoint = try await MusadoraLabsKit.librarySong(id: id)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/songs/i.gelNOzPuL41Lxo")
    }

    func testFetchMultipleLibrarySongsByIDsEndpoint() async throws {
        let ids = ["i.gelNOzPuL41Lxo"]
        let endpoint = try await MusadoraLabsKit.librarySongs(ids: ids)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/songs?ids=i.gelNOzPuL41Lxo")
    }

    func testFetchAllLibraryArtistsEndpoint() async throws {
        let endpoint = try await MusadoraLabsKit.librarySongs()
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/songs")
    }
}
