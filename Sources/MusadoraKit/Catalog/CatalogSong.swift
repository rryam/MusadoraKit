//
//  CatalogSong.swift
//  CatalogSong
//
//  Created by Rudrank Riyam on 14/08/21.
//

import MusicKit

/// A collection of songs.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public typealias Songs = MusicItemCollection<Song>

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension MusadoraKit {

    /// Fetch a song from the Apple Music catalog by using its identifier.
    /// - Parameters:
    ///   - id: The unique identifier for the song.
    ///   - properties: Additional relationships to fetch with the song.
    /// - Returns: `Song` matching the given identifier.
    static func catalogSong(id: MusicItemID,
                            with properties: [PartialMusicAsyncProperty<Song>] = []) async throws -> Song {
        var request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
        request.properties = properties
        let response = try await request.response()
        
        guard let song = response.items.first else {
            throw MusadoraKitError.notFound(for: id.rawValue)
        }
        return song
    }

    /// Fetch multiple songs from the Apple Music catalog by using their identifiers.
    /// - Parameters:
    ///   - ids: The unique identifiers for the songs.
    ///   - properties: Additional relationships to fetch with the songs.
    /// - Returns: `Songs` matching the given identifiers.
    static func catalogSongs(ids: [MusicItemID],
                             with properties: [PartialMusicAsyncProperty<Song>] = []) async throws -> Songs {
        var request = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
        request.properties = properties
        let response = try await request.response()
        return response.items
    }

    /// Fetch one or more songs from Apple Music catalog by using their ISRC value.
    ///
    /// Note that one ISRC value may return more than one song.
    /// - Parameters:
    ///   - isrc: The ISRC values for the songs.
    ///   - properties: Additional relationships to fetch with the songs.
    /// - Returns: `Songs` matching the given ISRC value.
    static func catalogSong(isrc: String,
                            with properties: [PartialMusicAsyncProperty<Song>] = []) async throws -> Songs {
        var request = MusicCatalogResourceRequest<Song>(matching: \.isrc, equalTo: isrc)
        request.properties = properties
        let response = try await request.response()
        return response.items
    }

    /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
    ///
    /// Note that one ISRC value may return more than one song.
    /// - Parameters:
    ///   - isrc: The ISRC values for the songs.
    ///   - properties: Additional relationships to fetch with the songs.
    /// - Returns: `Songs` matching the given ISRC values.
    static func catalogSongs(isrc: [String],
                             with properties: [PartialMusicAsyncProperty<Song>] = []) async throws -> Songs {
        var request = MusicCatalogResourceRequest<Song>(matching: \.isrc, memberOf: isrc)
        request.properties = properties
        let response = try await request.response()
        return response.items
    }
}
