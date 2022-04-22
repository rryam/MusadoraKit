//
//  MusicHistoryResponse.swift
//  MusicHistoryResponse
//
//  Created by Rudrank Riyam on 02/04/22.
//

import MusicKit

/// A collection of tracks
public typealias Tracks = MusicItemCollection<Track>

/// An object that contains results for a history request.
public struct MusicHistoryResponse {

    /// A collection of historical resources based on the `MusicHistoryRequest`.
    public let items: UserMusicItems

    /// A collection of historical albums.
    public var albums: Albums {
        MusicItemCollection(items.compactMap { item in
            if case let .album(album) = item {
                return album
            } else {
                return nil
            }
        })
    }

    /// A collection of historical playlists.
    public var playlists: Playlists {
        MusicItemCollection(items.compactMap { item in
            if case let .playlist(playlist) = item {
                return playlist
            } else {
                return nil
            }
        })
    }

    /// A collection of historical stations.
    public var stations: Stations {
        MusicItemCollection(items.compactMap { item in
            if case let .station(station) = item {
                return station
            } else {
                return nil
            }
        })
    }

    /// A collection of historical tracks.
    public var tracks: Tracks {
        MusicItemCollection(items.compactMap { item in
            if case let .track(track) = item {
                return track
            } else {
                return nil
            }
        })
    }
}

extension MusicHistoryResponse: Equatable, Hashable, Codable {}

extension MusicHistoryResponse: CustomStringConvertible {
    public var description: String {
        "MusicHistoryResponse(\(items.description)"
    }
}
