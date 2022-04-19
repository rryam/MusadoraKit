//
//  MusicVideosEndpointTests.swift
//  MusicVideosEndpointTests
//
//  Created by Rudrank Riyam on 19/04/22.
//

import XCTest
@testable import MusadoraLabsKit

class MusicVideosEndpointTests: XCTestCase {
    // MARK: - Catalog Music Videos Tests
    func testFetchACatalogMusicVideosByIDEndpoint() async throws {
        let id = "1560735548"
        let endpoint = try await MusadoraLabsKit.catalogMusicVideo(id: id, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/music-videos/1560735548")
    }

    func testFetchMultipleCatalogMusicVideosByIDsEndpoint() async throws {
        let ids = ["1560735548", "1572278914"]
        let endpoint = try await MusadoraLabsKit.catalogMusicVideos(ids: ids, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/music-videos?ids=1560735548,1572278914")
    }

    func testFetchMultipleCatalogMusicVideosByISRCEndpoint() async throws {
        let isrcs = ["USUM72105936"]
        let endpoint = try await MusadoraLabsKit.catalogMusicVideos(isrcs: isrcs, storeFront: "us")
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/catalog/us/music-videos?filter[isrc]=USUM72105936")
    }

    // MARK: - Library Music Videos Tests
    func testFetchALibraryMusicVideoByIDEndpoint() async throws {
        let id = "i.gelNOzPuL41Lxo"
        let endpoint = try await MusadoraLabsKit.libraryMusicVideo(id: id)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/music-videos/i.gelNOzPuL41Lxo")
    }

    func testFetchMultipleLibraryMusicVideosByIDsEndpoint() async throws {
        let ids = ["i.gelNOzPuL41Lxo"]
        let endpoint = try await MusadoraLabsKit.libraryMusicVideos(ids: ids)
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/music-videos?ids=i.gelNOzPuL41Lxo")
    }

    func testFetchAllLibraryArtistsEndpoint() async throws {
        let endpoint = try await MusadoraLabsKit.libraryMusicVideos()
        XCTAssertEqualEndpoint(endpoint, "https://api.music.apple.com/v1/me/library/music-videos")
    }
}
