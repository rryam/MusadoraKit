//
//  MStationTrackRequest.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation


struct MStationTrackRequest {
  var limit: Int = 20

  private let station: Station

  init(for station: Station) {
    self.station = station
  }

  func response() async throws -> Songs {
    let url = try stationTracksEndpointURL
    let postRequest = MDataPostRequest(url: url)

    return try await stationSongs(for: postRequest)
  }

  private func stationSongs(for postRequest: MDataPostRequest) async throws -> Songs {
    try await withThrowingTaskGroup(of: Songs.self) { group in
      let iteratorLimit = limit / 10

      for _ in stride(from: 0, to: iteratorLimit, by: 1) {
        group.addTask {
          let response = try await postRequest.response()
          return try JSONDecoder().decode(Songs.self, from: response.data)
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

extension MStationTrackRequest {
  internal var stationTracksEndpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      components.path = "me/stations/next-tracks/\(station.id.rawValue)"

      components.queryItems = [URLQueryItem(name: "limit", value: "10")]

      guard let url = components.url else {
        throw URLError(.badURL)
      }
      return url
    }
  }
}
