//
//  MusadoraKit.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation
@_exported import MusicKit

/// MusadoraKit: The ultimate companion to MusicKit.
public struct MusadoraKit {}

/// There are five types of structures that you can use in your app.
/// You DON'T use the `MusadoraKit` structure anymore to access the
/// static methods.

/// The five types are:
/// 1. `MCatalog` for accessing the Apple Music catalog. (including catalog search)
/// 2. `MLibrary` for accessing the user's library . (including library search)
/// 3. `MRecommendation` for accessing the user's recommendations.
/// 4. `MHistory` for accessing historical data.
/// 5. `MRating` for working with ratings.

extension MusadoraKit {
  public static var userToken: String? {
    ProcessInfo.processInfo.environment["USER_TOKEN"]
  }
}
