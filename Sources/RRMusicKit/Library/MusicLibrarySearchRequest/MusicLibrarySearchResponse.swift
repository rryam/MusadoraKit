//
//  MusicLibrarySearchResponse.swift
//  MusicLibrarySearchResponse
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

public struct MusicLibrarySearchResponse {
    public let songs: Songs
    public let artists: Artists
    public let albums: Albums
    public let musicVideos: MusicVideos
    public let playlists: Playlists
}

extension MusicLibrarySearchResponse: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MusicLibrarySearchType.self)
        
        songs = try container.decodeIfPresent(Songs.self, forKey: .songs) ?? []
        artists = try container.decodeIfPresent(Artists.self, forKey: .artists) ?? []
        albums = try container.decodeIfPresent(Albums.self, forKey: .albums) ?? []
        musicVideos = try container.decodeIfPresent(MusicVideos.self, forKey: .musicVideos) ?? []
        playlists = try container.decodeIfPresent(Playlists.self, forKey: .playlists) ?? []
    }
}
