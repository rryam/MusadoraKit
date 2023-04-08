//
//  ContinuousSongs.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

public extension MRecommendation {

  /// Retrieves recommended songs from the Apple Music catalog for a given song, with the option to limit the number of results.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let song: Song = ...
  ///       let recommendedSongs = try await MRecommendation.continuousSongs(for: song, limit: 10)
  ///
  ///       for recommendedSong in recommendedSongs {
  ///         print("Recommended song name: \(recommendedSong.title)")
  ///         print("Recommended song artist: \(recommendedSong.artistName)")
  ///         // access other recommended song properties as needed
  ///       }
  ///     } catch {
  ///       print("Error retrieving recommended songs: \(error.localizedDescription)")
  ///     }
  ///
  /// - Parameters:
  ///   - song: The song for which you want to retrieve recommendations.
  ///   - limit: Determines the number of recommendations you want to retrieve. The default value is 20.
  ///
  /// - Returns: An array of `Song` objects containing the recommended songs.
  ///
  /// - Note: This method uses a private endpoint and should be used at your own risk.
  @available(*, message: "THIS IS A PRIVATE ENDPOINT. USE IT AT YOUR OWN RISK.")
  static func continuousSongs(for song: Song, limit: Int = 20) async throws -> Songs {
    var request = MContinuousTrackRequest(for: song)
    request.limit = limit
    let response = try await request.response()
    return response
  }
}
