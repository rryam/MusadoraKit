//
//  StationSongs.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

public extension MRecommendation {

  /// Retrieves station songs from the Apple Music catalog for a given station, with the option to limit the number of results.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let station: Station = ...
  ///       let stationSongs = try await MRecommendation.stationSongs(for: station, limit: 10)
  ///
  ///       for stationSong in stationSongs {
  ///         print("Station song name: \(stationSong.title)")
  ///         print("Station song artist: \(stationSong.artistName)")
  ///         // access other station song properties as needed
  ///       }
  ///     } catch {
  ///       print("Error retrieving station songs: \(error.localizedDescription)")
  ///     }
  ///
  /// - Parameters:
  ///   - station: The station for which you want to retrieve the songs. This parameter is of type `Station`, which is a custom type defined in the MusadoraKit library.
  ///   - limit: Determines the number of songs you want to retrieve. The default value is 20.
  ///
  /// - Returns: An array of `Song` objects containing the station songs.
  ///
  /// - Note: This method uses a private endpoint and should be used at your own risk. This functionality is not available in the official Apple Music app.
  @available(*, message: "THIS IS A PRIVATE ENDPOINT. USE IT AT YOUR OWN RISK.")
  static func stationSongs(for station: Station, limit: Int = 20) async throws -> Songs {
    var request = MStationTrackRequest(for: station)
    request.limit = limit
    let response = try await request.response()
    return response
  }
}
