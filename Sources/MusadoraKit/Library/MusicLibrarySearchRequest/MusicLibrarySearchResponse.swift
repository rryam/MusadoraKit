//
//  MusicLibrarySearchResponse.swift
//  MusicLibrarySearchResponse
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// An object that contains results for a library search request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct MusicLibrarySearchResponse: Equatable, Hashable {
    
    /// A collection of songs.
    public let songs: Songs
    
    /// A collection of artists.
    public let artists: Artists
    
    /// A collection of albums.
    public let albums: Albums
    
    /// A collection of music videos.
    public let musicVideos: MusicVideos
    
    /// A collection of playlists.
    public let playlists: Playlists
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension MusicLibrarySearchResponse: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MusicLibrarySearchType.self)
        
        songs = try container.decodeIfPresent(Songs.self, forKey: .songs) ?? []
        artists = try container.decodeIfPresent(Artists.self, forKey: .artists) ?? []
        albums = try container.decodeIfPresent(Albums.self, forKey: .albums) ?? []
        musicVideos = try container.decodeIfPresent(MusicVideos.self, forKey: .musicVideos) ?? []
        playlists = try container.decodeIfPresent(Playlists.self, forKey: .playlists) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MusicLibrarySearchType.self)
        
        try container.encode(songs, forKey: .songs)
        try container.encode(artists, forKey: .artists)
        try container.encode(albums, forKey: .albums)
        try container.encode(musicVideos, forKey: .musicVideos)
        try container.encode(playlists, forKey: .playlists)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension MusicLibrarySearchResponse : CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        var description = "MusicLibrarySearchResponse("
        let mirror = Mirror(reflecting: self)
        
        description += mirror.children.map { "\n\($0.value)," }.joined()
        
        return description + "\n)"
    }
    
    public var debugDescription: String {
        "MusicLibrarySearchResponse(\n\(self.songs.debugDescription),\n\(self.artists.debugDescription),\n\(self.albums.debugDescription),\n\(self.musicVideos.debugDescription),\(self.playlists.debugDescription)\n)"
    }
}
