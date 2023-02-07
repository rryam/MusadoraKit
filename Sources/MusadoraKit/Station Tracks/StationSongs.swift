//
//  StationSongs.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation
import MusicKit

extension MRecommendation {
  /// Retrieve the station songs from Apple Music catalog for a given station, with the option to limit the number of results.
  /// This is not possible to do in the official Apple Music app.
  ///
  /// - Parameters:
  ///    - station: The station for which you want to retrieve the songs.
  ///    - limit: Determines the number of songs you want to retrieve. The default value is 20.
  /// - Returns: `Songs` containing the station songs.
  @available(*, message: "THIS IS A PRIVATE ENDPOINT. USE IT AT YOUR OWN RISK.")
  static func stationSongs(for station: Station, limit: Int = 20) async throws -> Songs {
    var request = MStationTrackRequest(for: station)
    request.limit = limit
    let response = try await request.response()
    return response
  }
}
