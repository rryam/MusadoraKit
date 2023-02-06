//
//  ContinuousSongs.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import MusicKit

public extension MRecommendation {
  /// Retrieve recommended songs from Apple Music catalog for a given song, with the option to limit the number of results.
  ///
  /// - Parameters:
  ///    - song: The song for which you want to retrieve recommendations.
  ///    - limit: Determines the number of recommendations you want to retrieve. The default value is 20.
  /// - Returns: `Songs` containing the recommended songs.
  @available(*, message: "THIS IS A PRIVATE ENDPOINT. USE IT AT YOUR OWN RISK.")
  static func continuousSongs(for song: Song, limit: Int = 20) async throws -> Songs {
    var request = MContinuousTrackRequest(for: song)
    request.limit = limit
    let response = try await request.response()
    return response
  }
}
