//
//  CatalogEndpointMacroTests.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 21/06/25.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Import the macro implementation.
@testable import MusadoraKitMacros

final class CatalogEndpointMacroTests: XCTestCase {
    let testMacros: [String: Macro.Type] = [
        "CatalogEndpoint": CatalogEndpointMacro.self
    ]
    
    func testCatalogEndpointMacroGeneratesCorrectMethodsForAlbum() throws {
        assertMacroExpansion(
            """
            @CatalogEndpoint(resource: Album.self)
            public extension MCatalog {}
            """,
            expandedSource: """
            public extension MCatalog {
                /// Fetch an album from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the album.
                ///   - properties: Additional relationships to fetch with the album.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Album` matching the given identifier.
                static func album(id: MusicItemID, fetch properties: AlbumProperties) async throws -> Album {
                    var request = MusicCatalogResourceRequest<Album>(matching: \\.id, equalTo: id)
                    request.properties = properties
                    let response = try await request.response()
                    
                    guard let album = response.items.first else {
                        throw MusadoraKitError.notFound(for: id.rawValue)
                    }
                    return album
                }
                /// Fetch an album from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the album.
                ///   - properties: Additional relationships to fetch with the album.
                /// - Returns: `Album` matching the given identifier.
                static func album(id: MusicItemID, fetch properties: AlbumProperty...) async throws -> Album {
                    try await album(id: id, fetch: properties)
                }
                /// Fetch an album from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the album.
                ///   - property: Additional property or relationship to fetch with the album.
                /// - Returns: `Album` matching the given identifier.
                static func album(id: MusicItemID, fetch property: AlbumProperty) async throws -> Album {
                    try await album(id: id, fetch: [property])
                }
                /// Fetch an album from the Apple Music catalog by using its identifier with all properties.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the album.
                /// - Returns: `Album` matching the given identifier.
                static func album(id: MusicItemID) async throws -> Album {
                    try await album(id: id, fetch: .all)
                }
                /// Fetch one or more albums from the Apple Music catalog by using their identifiers.
                ///
                /// - Parameters:
                ///   - ids: The unique identifiers for the albums.
                ///   - properties: Additional relationships to fetch with the albums.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Albums` matching the given identifiers.
                static func albums(ids: [MusicItemID], fetch properties: AlbumProperties) async throws -> Albums {
                    var request = MusicCatalogResourceRequest<Album>(matching: \\.id, memberOf: ids)
                    request.properties = properties
                    let response = try await request.response()
                    return response.items
                }
                /// Fetch one or more albums from the Apple Music catalog by using their identifiers with all properties.
                ///
                /// - Parameters:
                ///   - ids: The unique identifiers for the albums.
                /// - Returns: `Albums` matching the given identifiers.
                static func albums(ids: [MusicItemID]) async throws -> Albums {
                    try await albums(ids: ids, fetch: .all)
                }
                /// Fetch an album from Apple Music catalog by using its UPC value.
                ///
                /// - Parameters:
                ///   - upc: The UPC (Universal Product Code) value for the album.
                ///   - properties: Additional relationships to fetch with the album.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Album` matching the given UPC value.
                static func albums(upc: String, fetch properties: AlbumProperties) async throws -> Album {
                    var request = MusicCatalogResourceRequest<Album>(matching: \\.upc, equalTo: upc)
                    request.properties = properties
                    let response = try await request.response()
                    
                    guard let album = response.items.first else {
                        throw MusadoraKitError.notFound(for: upc)
                    }
                    return album
                }
                /// Fetch an album from Apple Music catalog by using its UPC value with all properties.
                ///
                /// - Parameters:
                ///   - upc: The UPC (Universal Product Code) value for the album.
                /// - Returns: `Album` matching the given UPC value.
                static func albums(upc: String) async throws -> Album {
                    try await albums(upc: upc, fetch: .all)
                }
                /// Fetch multiple albums from Apple Music catalog by using their UPC values.
                ///
                /// - Parameters:
                ///   - upcs: The UPC (Universal Product Code) values for the albums.
                ///   - properties: Additional relationships to fetch with the albums.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Albums` matching the given UPC values.
                static func albums(upcs: [String], fetch properties: AlbumProperties) async throws -> Albums {
                    var request = MusicCatalogResourceRequest<Album>(matching: \\.upc, memberOf: upcs)
                    request.properties = properties
                    let response = try await request.response()
                    return response.items
                }
                /// Fetch multiple albums from Apple Music catalog by using their UPC values with all properties.
                ///
                /// - Parameters:
                ///   - upcs: The UPC (Universal Product Code) values for the albums.
                /// - Returns: `Albums` matching the given UPC values.
                static func albums(upcs: [String]) async throws -> Albums {
                    try await albums(upcs: upcs, fetch: .all)
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testCatalogEndpointMacroGeneratesISRCMethodsForSong() throws {
        assertMacroExpansion(
            """
            @CatalogEndpoint(resource: Song.self)
            public extension MCatalog {}
            """,
            expandedSource: """
            public extension MCatalog {
                /// Fetch a song from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the song.
                ///   - properties: Additional relationships to fetch with the song.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Song` matching the given identifier.
                static func song(id: MusicItemID, fetch properties: SongProperties) async throws -> Song {
                    var request = MusicCatalogResourceRequest<Song>(matching: \\.id, equalTo: id)
                    request.properties = properties
                    let response = try await request.response()
                    
                    guard let song = response.items.first else {
                        throw MusadoraKitError.notFound(for: id.rawValue)
                    }
                    return song
                }
                /// Fetch a song from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the song.
                ///   - properties: Additional relationships to fetch with the song.
                /// - Returns: `Song` matching the given identifier.
                static func song(id: MusicItemID, fetch properties: SongProperty...) async throws -> Song {
                    try await song(id: id, fetch: properties)
                }
                /// Fetch a song from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the song.
                ///   - property: Additional property or relationship to fetch with the song.
                /// - Returns: `Song` matching the given identifier.
                static func song(id: MusicItemID, fetch property: SongProperty) async throws -> Song {
                    try await song(id: id, fetch: [property])
                }
                /// Fetch a song from the Apple Music catalog by using its identifier with all properties.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the song.
                /// - Returns: `Song` matching the given identifier.
                static func song(id: MusicItemID) async throws -> Song {
                    try await song(id: id, fetch: .all)
                }
                /// Fetch one or more songs from the Apple Music catalog by using their identifiers.
                ///
                /// - Parameters:
                ///   - ids: The unique identifiers for the songs.
                ///   - properties: Additional relationships to fetch with the songs.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Songs` matching the given identifiers.
                static func songs(ids: [MusicItemID], fetch properties: SongProperties) async throws -> Songs {
                    var request = MusicCatalogResourceRequest<Song>(matching: \\.id, memberOf: ids)
                    request.properties = properties
                    let response = try await request.response()
                    return response.items
                }
                /// Fetch one or more songs from the Apple Music catalog by using their identifiers with all properties.
                ///
                /// - Parameters:
                ///   - ids: The unique identifiers for the songs.
                /// - Returns: `Songs` matching the given identifiers.
                static func songs(ids: [MusicItemID]) async throws -> Songs {
                    try await songs(ids: ids, fetch: .all)
                }
                /// Fetch a song from Apple Music catalog by using its UPC value.
                ///
                /// - Parameters:
                ///   - upc: The UPC (Universal Product Code) value for the song.
                ///   - properties: Additional relationships to fetch with the song.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Song` matching the given UPC value.
                static func songs(upc: String, fetch properties: SongProperties) async throws -> Song {
                    var request = MusicCatalogResourceRequest<Song>(matching: \\.upc, equalTo: upc)
                    request.properties = properties
                    let response = try await request.response()
                    
                    guard let song = response.items.first else {
                        throw MusadoraKitError.notFound(for: upc)
                    }
                    return song
                }
                /// Fetch a song from Apple Music catalog by using its UPC value with all properties.
                ///
                /// - Parameters:
                ///   - upc: The UPC (Universal Product Code) value for the song.
                /// - Returns: `Song` matching the given UPC value.
                static func songs(upc: String) async throws -> Song {
                    try await songs(upc: upc, fetch: .all)
                }
                /// Fetch multiple songs from Apple Music catalog by using their UPC values.
                ///
                /// - Parameters:
                ///   - upcs: The UPC (Universal Product Code) values for the songs.
                ///   - properties: Additional relationships to fetch with the songs.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Songs` matching the given UPC values.
                static func songs(upcs: [String], fetch properties: SongProperties) async throws -> Songs {
                    var request = MusicCatalogResourceRequest<Song>(matching: \\.upc, memberOf: upcs)
                    request.properties = properties
                    let response = try await request.response()
                    return response.items
                }
                /// Fetch multiple songs from Apple Music catalog by using their UPC values with all properties.
                ///
                /// - Parameters:
                ///   - upcs: The UPC (Universal Product Code) values for the songs.
                /// - Returns: `Songs` matching the given UPC values.
                static func songs(upcs: [String]) async throws -> Songs {
                    try await songs(upcs: upcs, fetch: .all)
                }
                /// Fetch a song from Apple Music catalog by using its ISRC value.
                ///
                /// - Parameters:
                ///   - isrc: The ISRC (International Standard Recording Code) value for the song.
                ///   - properties: Additional relationships to fetch with the song.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Song` matching the given ISRC value.
                static func songs(isrc: String, fetch properties: SongProperties) async throws -> Song {
                    var request = MusicCatalogResourceRequest<Song>(matching: \\.isrc, equalTo: isrc)
                    request.properties = properties
                    let response = try await request.response()
                    
                    guard let song = response.items.first else {
                        throw MusadoraKitError.notFound(for: isrc)
                    }
                    return song
                }
                /// Fetch a song from Apple Music catalog by using its ISRC value with all properties.
                ///
                /// - Parameters:
                ///   - isrc: The ISRC (International Standard Recording Code) value for the song.
                /// - Returns: `Song` matching the given ISRC value.
                static func songs(isrc: String) async throws -> Song {
                    try await songs(isrc: isrc, fetch: .all)
                }
                /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
                ///
                /// - Parameters:
                ///   - isrcs: The ISRC (International Standard Recording Code) values for the songs.
                ///   - properties: Additional relationships to fetch with the songs.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Songs` matching the given ISRC values.
                static func songs(isrcs: [String], fetch properties: SongProperties) async throws -> Songs {
                    var request = MusicCatalogResourceRequest<Song>(matching: \\.isrc, memberOf: isrcs)
                    request.properties = properties
                    let response = try await request.response()
                    return response.items
                }
                /// Fetch multiple songs from Apple Music catalog by using their ISRC values with all properties.
                ///
                /// - Parameters:
                ///   - isrcs: The ISRC (International Standard Recording Code) values for the songs.
                /// - Returns: `Songs` matching the given ISRC values.
                static func songs(isrcs: [String]) async throws -> Songs {
                    try await songs(isrcs: isrcs, fetch: .all)
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testCatalogEndpointMacroGeneratesCorrectMethodsForArtist() throws {
        assertMacroExpansion(
            """
            @CatalogEndpoint(resource: Artist.self)
            public extension MCatalog {}
            """,
            expandedSource: """
            public extension MCatalog {
                /// Fetch an artist from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the artist.
                ///   - properties: Additional relationships to fetch with the artist.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Artist` matching the given identifier.
                static func artist(id: MusicItemID, fetch properties: ArtistProperties) async throws -> Artist {
                    var request = MusicCatalogResourceRequest<Artist>(matching: \\.id, equalTo: id)
                    request.properties = properties
                    let response = try await request.response()
                    
                    guard let artist = response.items.first else {
                        throw MusadoraKitError.notFound(for: id.rawValue)
                    }
                    return artist
                }
                /// Fetch an artist from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the artist.
                ///   - properties: Additional relationships to fetch with the artist.
                /// - Returns: `Artist` matching the given identifier.
                static func artist(id: MusicItemID, fetch properties: ArtistProperty...) async throws -> Artist {
                    try await artist(id: id, fetch: properties)
                }
                /// Fetch an artist from the Apple Music catalog by using its identifier.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the artist.
                ///   - property: Additional property or relationship to fetch with the artist.
                /// - Returns: `Artist` matching the given identifier.
                static func artist(id: MusicItemID, fetch property: ArtistProperty) async throws -> Artist {
                    try await artist(id: id, fetch: [property])
                }
                /// Fetch an artist from the Apple Music catalog by using its identifier with all properties.
                ///
                /// - Parameters:
                ///   - id: The unique identifier for the artist.
                /// - Returns: `Artist` matching the given identifier.
                static func artist(id: MusicItemID) async throws -> Artist {
                    try await artist(id: id, fetch: .all)
                }
                /// Fetch one or more artists from the Apple Music catalog by using their identifiers.
                ///
                /// - Parameters:
                ///   - ids: The unique identifiers for the artists.
                ///   - properties: Additional relationships to fetch with the artists.
                ///   Pass an empty array to avoid fetching additional properties.
                /// - Returns: `Artists` matching the given identifiers.
                static func artists(ids: [MusicItemID], fetch properties: ArtistProperties) async throws -> Artists {
                    var request = MusicCatalogResourceRequest<Artist>(matching: \\.id, memberOf: ids)
                    request.properties = properties
                    let response = try await request.response()
                    return response.items
                }
                /// Fetch one or more artists from the Apple Music catalog by using their identifiers with all properties.
                ///
                /// - Parameters:
                ///   - ids: The unique identifiers for the artists.
                /// - Returns: `Artists` matching the given identifiers.
                static func artists(ids: [MusicItemID]) async throws -> Artists {
                    try await artists(ids: ids, fetch: .all)
                }
            }
            """,
            macros: testMacros
        )
    }
}