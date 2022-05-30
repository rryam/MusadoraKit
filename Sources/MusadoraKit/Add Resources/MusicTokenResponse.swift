//
//  MusicTokenResponse.swift
//  MusicTokenResponse
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// An object containing results for a post data request.
public struct MusicDataPostResponse {
  /// The raw data returned by the Apple Music API endpoint
  /// for the originating data request.
  public let data: Data

  /// The URL response returned by the Apple Music API endpoint
  /// for the originating data request.
  public let urlResponse: HTTPURLResponse
}
