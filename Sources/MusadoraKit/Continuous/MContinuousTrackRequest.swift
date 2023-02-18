//
//  MContinuousTrackRequest.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation
import MusicKit

struct MContinuousTrackRequest {
  var limit: Int = 20
  private let song: Song

  init(for song: Song) {
    self.song = song
  }

  private func createPostRequest(for song: Song, album: Album?) throws -> MDataPostRequest {
    guard let album = album else {
      throw NSError(domain: "No album exists for this song.", code: 0)
    }

    let trackData = MContinuousTrackData(songID: song.id, albumID: album.id)
    let url = try continuousTracksEndpointURL
    let data = try JSONEncoder().encode(trackData)

    let postRequest = MDataPostRequest(url: url, data: data)
    return postRequest
  }

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
