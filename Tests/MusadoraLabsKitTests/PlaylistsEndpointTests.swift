//
//  PlaylistsEndpointTests.swift
//  PlaylistsEndpointTests
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

import XCTest
@testable import MusadoraLabsKit

class PlaylistsEndpointTests: XCTestCase {
    // MARK: - Catalog Playlists Tests
    func testFetchACatalogPlaylistsByIDEndpoint() async throws {
        let id = "pl.f4d106fed2bd41149aaacabb233eb5eb"
        let endpoint = try await MusadoraLabsKit.catalogPlaylist(id: id, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/playlists/pl.f4d106fed2bd41149aaacabb233eb5eb")
    }

    func testFetchMultipleCatalogPlaylistsByIDsEndpoint() async throws {
        let ids = ["pl.f4d106fed2bd41149aaacabb233eb5eb"]
        let endpoint = try await MusadoraLabsKit.catalogPlaylists(ids: ids, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/playlists?ids=pl.f4d106fed2bd41149aaacabb233eb5eb")
    }

    // MARK: - Library Playlists Tests
    func testFetchALibraryPlaylistByIDEndpoint() async throws {
        let id = "p.ldvAAZ3C3Qmop9"
        let endpoint = try await MusadoraLabsKit.libraryPlaylist(id: id)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/playlists/p.ldvAAZ3C3Qmop9")
    }

    func testFetchMultipleLibraryPlaylistsByIDsEndpoint() async throws {
        let ids = ["p.ldvAAZ3C3Qmop9"]
        let endpoint = try await MusadoraLabsKit.libraryPlaylists(ids: ids)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/playlists?ids=p.ldvAAZ3C3Qmop9")
    }

    func testFetchAllLibraryPlaylistsEndpoint() async throws {
        let endpoint = try await MusadoraLabsKit.libraryPlaylists()
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/playlists")
    }
}
