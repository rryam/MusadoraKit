//
//  MusicItemPropertiesTests.swift
//  MusadoraKitTests
//
//  Created by Rudrank Riyam on 22/03/23.
//

@testable import MusadoraKit
import MusicKit
import XCTest

final class MusicItemPropertiesTests: XCTestCase {
  func testPlaylistPropertiesAll() {
    let allProperties = PlaylistProperties.all
    var expectedProperties: Set<PlaylistProperty> = [.tracks, .featuredArtists, .moreByCurator]

    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
      expectedProperties.insert(.curator)
      expectedProperties.insert(.radioShow)
    }

    XCTAssertTrue(expectedProperties.isSubset(of: allProperties))
  }

  func testSongPropertiesAll() {
    let allProperties = SongProperties.all
    var expectedProperties: Set<SongProperty> = [.albums, .artists, .composers, .genres, .musicVideos, .artistURL, .station]

    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
      expectedProperties.insert(.audioVariants)
    }

    XCTAssertTrue(expectedProperties.isSubset(of: allProperties))
  }

  func testRecordLabelPropertiesAll() {
    let allProperties = RecordLabelProperties.all
    let expectedProperties: Set<RecordLabelProperty> = [.latestReleases, .topReleases]

    XCTAssertTrue(expectedProperties.isSubset(of: allProperties))
  }

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
  func testRadioShowPropertiesAll() {
    let allProperties = RadioShowProperties.all
    let expectedProperties: Set<RadioShowProperty> = [.playlists]

    XCTAssertTrue(expectedProperties.isSubset(of: allProperties))
  }

  func testMusicVideoPropertiesAll() {
    let allProperties = MusicVideoProperties.all
    let expectedProperties: Set<MusicVideoProperty> = [.albums, .genres, .artists, .artistURL, .moreInGenre, .songs, .moreByArtist]

    XCTAssertTrue(expectedProperties.isSubset(of: allProperties))
  }

  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
  func testCuratorPropertiesAll() {
    let allProperties = CuratorProperties.all
    let expectedProperties: Set<CuratorProperty> = [.playlists]

    XCTAssertTrue(expectedProperties.isSubset(of: allProperties))
  }

  func testArtistPropertiesAll() {
    let allProperties = ArtistProperties.all
    let expectedProperties: Set<ArtistProperty> = [.genres, .station, .musicVideos, .albums, .playlists, .appearsOnAlbums, .fullAlbums, .featuredAlbums, .liveAlbums, .compilationAlbums, .featuredPlaylists, .latestRelease, .topSongs, .topMusicVideos, .similarArtists, .singles]

    XCTAssertTrue(expectedProperties.isSubset(of: allProperties))
  }

  func testAlbumPropertiesAll() {
    let allProperties = AlbumProperties.all
    var expectedProperties: Set<AlbumProperty> = [.artistURL, .genres, .artists, .appearsOn, .otherVersions, .recordLabels, .relatedAlbums, .relatedVideos, .tracks]

    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
      expectedProperties.insert(.audioVariants)
    }

    XCTAssertTrue(expectedProperties.isSubset(of: allProperties))
  }
}
