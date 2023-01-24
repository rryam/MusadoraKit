//
//  MHistoryEndpoints.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

/// Different endpoints related to historial data.
/// Possible types: Heavy rotation, recently added, and recently played resources.
enum MHistoryEndpoints {
  case heavyRotation
  case recentlyAdded
  case recentlyPlayed
  case recentlyPlayedTracks
  case recentlyPlayedStations

  var path: String {
    switch self {
      case .heavyRotation:
        return "history/heavy-rotation"
      case .recentlyAdded:
        return "library/recently-added"
      case .recentlyPlayed:
        return "recent/played"
      case .recentlyPlayedTracks:
        return "recent/played/tracks"
      case .recentlyPlayedStations:
        return "recent/radio-stations"
    }
  }

  var maximumLimit: Int {
    switch self {
      case .heavyRotation, .recentlyPlayed, .recentlyPlayedStations:
        return 10
      case .recentlyAdded:
        return 25
      case .recentlyPlayedTracks:
        return 30
    }
  }
}
