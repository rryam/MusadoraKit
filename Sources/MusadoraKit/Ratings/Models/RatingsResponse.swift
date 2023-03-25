//
//  RatingsResponse.swift
//  RatingsResponse
//
//  Created by Rudrank Riyam on 20/05/22.
//

import Foundation

/// An object that contains results for a rating request.
public struct RatingsResponse: Codable {

  /// A collection of ratings
  public let data: Ratings
}
