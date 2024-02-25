//
//  MStationTrackRequest.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation

/// A request that your app uses to fetch tracks for a specific station.
struct MStationTrackRequest {

  /// A limit for the number of items to return
  /// in the station tracks response. Default value is 20.
  var limit: Int = 20

  private let station: Station

  /// Creates a request to fetch tracks for a given station.
  /// - Parameter station: The station for which to fetch tracks.
  init(for station: Station) {
    self.station = station
  }

  /// Fetches tracks for the station associated with this request.
  func response() async throws -> Songs {
    let url = try stationTracksEndpointURL
    return try await stationSongs(for: url)
  }

  /// Fetches and processes station songs in parallel tasks.
  /// - Parameter postRequest: The request to fetch station songs.
  /// - Returns: An array of unique songs for the station.
  private func stationSongs(for url: URL) async throws -> Songs {
    try await withThrowingTaskGroup(of: Songs.self) { group in
      let iteratorLimit = limit / 10

      for _ in stride(from: 0, to: iteratorLimit, by: 1) {
        group.addTask {
          if let userToken = MusadoraKit.userToken {
            var postRequest = URLRequest(url: url)
            postRequest.httpMethod = "POST"
            let request = MUserRequest(urlRequest: .init(url: url), userToken: userToken)
            let data = try await request.response()
            return try JSONDecoder().decode(Songs.self, from: data)
          } else {
            let postRequest = MDataPostRequest(url: url)
            let response = try await postRequest.response()
            return try JSONDecoder().decode(Songs.self, from: response.data)
          }
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
