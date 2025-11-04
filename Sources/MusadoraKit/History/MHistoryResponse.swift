//
//  MHistoryResponse.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

/// An object that contains results for a history request.
///
/// This structure provides access to a user's historical music activity,
/// including recently played items and recently added content.
///
/// Example usage:
/// ```swift
/// let request = MusicHistoryRequest()
/// let response = try await request.response()
///
/// // Access historical items by type
/// print(response.albums)  // Recently played albums
/// print(response.tracks)  // Recently played tracks
/// print(response.playlists)  // Recently played playlists
/// ```
struct MHistoryResponse {
  /// A collection of historical resources based on the `MusicHistoryRequest`.
  let items: UserMusicItems

  /// A collection of historical albums.
  var albums: Albums {
    MusicItemCollection(
      items.compactMap { item in
        guard case let .album(album) = item else { return nil }
        return album
      })
  }

  /// A collection of historical playlists.
  var playlists: Playlists {
    MusicItemCollection(
      items.compactMap { item in
        guard case let .playlist(playlist) = item else { return nil }
        return playlist
      })
  }

  /// A collection of historical stations.
  var stations: Stations {
    MusicItemCollection(
      items.compactMap { item in
        guard case let .station(station) = item else { return nil }
        return station
      })
  }

  /// A collection of historical tracks.
  var tracks: Tracks {
    MusicItemCollection(
      items.compactMap { item in
        guard case let .track(track) = item else { return nil }
        return track
      })
  }
}

extension MHistoryResponse: Equatable, Hashable, Codable {}

extension MHistoryResponse: CustomStringConvertible {
  var description: String {
    "MusicHistoryResponse(\(items.description)"
  }
}
