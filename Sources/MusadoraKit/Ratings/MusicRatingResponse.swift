//
//  MusicRatingResponse.swift
//  MusicRatingResponse
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// An object that contains results for a rating request.
public struct MusicRatingResponse {
  /// A collection of ratings
  public let items: [Ratings]
}
