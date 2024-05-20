//
//  HundredBestAlbumIntegrationTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 20/05/24.
//

import XCTest
@testable import MusadoraKit

final class HundredBestAlbumIntegrationTests: XCTestCase {
  func testHundredBestAlbumAtPosition() async throws {
    let position = 100
    let album = try await MRecommendation.hundredBestAlbum(at: position)
    
    XCTAssertEqual(album.title, "Body Talk")
    XCTAssertEqual(album.artistName, "Robyn")
    XCTAssertEqual(album.position, "100")
    XCTAssertEqual(album.id, MusicItemID("1440714879"))
  }
  
  func testAllHundredBestAlbums() async throws {
    let albums = try await MRecommendation.allHundredBestAlbums()
    
    guard let eightyThirdAlbum = albums.first(where: { $0.position == "83" }) else {
      XCTFail("Failed to find the album at position 83")
      return
    }
    
    XCTAssertEqual(eightyThirdAlbum.title, "Horses ")
    XCTAssertEqual(eightyThirdAlbum.artistName, "Patti Smith")
    XCTAssertEqual(eightyThirdAlbum.position, "83")
    XCTAssertEqual(eightyThirdAlbum.id, MusicItemID("1038568061"))
    
    guard let fortyNinthAlbum = albums.first(where: { $0.position == "49" }) else {
      XCTFail("Failed to find the album at position 49")
      return
    }
    
    XCTAssertEqual(fortyNinthAlbum.title, "The Joshua Tree")
    XCTAssertEqual(fortyNinthAlbum.artistName, "U2")
    XCTAssertEqual(fortyNinthAlbum.position, "49")
    XCTAssertEqual(fortyNinthAlbum.id, MusicItemID("1443155637"))
  }
}
