//
//  MContinuousTrackResponse.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation

/// This struct represents the response for a continuous track request.
struct MContinuousTrackResponse: Codable {

  /// The results of the request.
  public let results: Results

  /// The nested struct for the results of the request.
  struct Results: Codable {

    /// The station associated with the request.
    public let station: Station

    /// The songs returned in the response.
    public let songs: Songs

    /// Coding keys to map the response fields to struct properties.
    enum CodingKeys: String, CodingKey {
      case station
      case songs = "tracks"
    }

    /// Initializes a Results instance by decoding data from a decoder.
    /// - Parameter decoder: The decoder to use for decoding the data.
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.station = try container.decode(Station.self, forKey: .station)
      let tracks = try container.decode([Track].self, forKey: .songs).compactMap { track in
        if case let .song(song) = track {
          return song
        } else {
          return nil
        }
      }

      self.songs = MusicItemCollection(tracks)
    }
  }
}
