//
//  MContinuousTrackResponse.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation


struct MContinuousTrackResponse: Codable {
	public let results: Results

	struct Results: Codable {
		public let station: Station
		public let songs: Songs

		enum CodingKeys: String, CodingKey {
			case station
			case songs = "tracks"
		}

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
