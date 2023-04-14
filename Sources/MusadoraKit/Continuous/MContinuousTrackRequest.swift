//
//  MContinuousTrackRequest.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation

/// Represents a continuous track request for a given `Song`.
struct MContinuousTrackRequest {

  /// The limit of songs to be returned in the response. Default value is `20`.
  var limit: Int = 20

  /// The song for which the continuous track request is to be made.
  private let song: Song

  /// Initializes a `MContinuousTrackRequest` object with the given `Song`.
  ///
  /// - Parameter song: The song for which the continuous track request is to be made.
  init(for song: Song) {
    self.song = song
  }

  /// Creates a `MDataPostRequest` object for the given `Song` and `Album`.
  ///
  /// - Parameters:
  ///   - song: The song for which the `MDataPostRequest` object is to be created.
  ///   - album: The album to which the song belongs.
  ///
  /// - Returns: A `MDataPostRequest` object for the given song and album.
  internal func createPostRequest(for song: Song, album: Album?) throws -> MDataPostRequest {
    guard let album = album else {
      throw NSError(domain: "No album exists for this song.", code: 0)
    }

    let trackData = MContinuousTrackData(songID: song.id, albumID: album.id)
    let url = try continuousTracksEndpointURL
    let data = try JSONEncoder().encode(trackData)

    let postRequest = MDataPostRequest(url: url, data: data)
    return postRequest
  }

  /// Sends a continuous track request and returns a list of songs.
  ///
  /// - Throws: An error if the request fails or no songs are returned.
  ///
  /// - Returns: A list of songs returned in the response.
  func response() async throws -> Songs {
    let playParametersData = try JSONEncoder().encode(song.playParameters)
    let playParameters = try JSONDecoder().decode(MusicPlayParameters.self, from: playParametersData)
    var postRequest: MDataPostRequest

    if let isLibrary = playParameters.isLibrary, isLibrary {
      let globalID = playParameters.globalId
      let catalogID = playParameters.catalogId

      let detailedSong = try await MCatalog.song(id: globalID ?? catalogID ?? song.id).with(.albums)
      let album = detailedSong.albums?.first
      postRequest = try createPostRequest(for: detailedSong, album: album)
    } else {
      let detailedSong = try await song.with(.albums)
      let album = detailedSong.albums?.first
      postRequest = try createPostRequest(for: detailedSong, album: album)
    }

    return try await continuousSongs(for: postRequest)
  }

  /// Sends multiple requests to get a list of continuous songs using a `TaskGroup`.
  ///
  /// - Parameter postRequest: The `MDataPostRequest` object to be used for sending the request.
  ///
  /// - Returns: A list of songs returned in the response.
  private func continuousSongs(for postRequest: MDataPostRequest) async throws -> Songs {
    try await withThrowingTaskGroup(of: Songs.self) { group in
      let iteratorLimit = limit / 10

      for _ in stride(from: 0, to: iteratorLimit, by: 1) {
        group.addTask {
          let response = try await postRequest.response()
          return try JSONDecoder().decode(MContinuousTrackResponse.self, from: response.data).results.songs
        }
      }

      var stationSongs: Songs = []

      for try await songs in group {
        for song in songs {
          if stationSongs.contains(where: { $0.id == song.id }) {
            // DUPLICATE
          } else {
            stationSongs += MusicItemCollection(arrayLiteral: song)
          }
        }
      }

      return stationSongs
    }
  }
}

extension MContinuousTrackRequest {
  internal var continuousTracksEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []
      components.path = "me/stations/continuous"

      queryItems.append(URLQueryItem(name: "limit[results:tracks]", value: "10"))
      queryItems.append(URLQueryItem(name: "with", value: "tracks"))

      components.queryItems = queryItems

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
