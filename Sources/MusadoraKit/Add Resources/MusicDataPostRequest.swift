//
//  MusicDataPostRequest.swift
//  MusicDataPostRequest
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation
import MusicKit

/// A request for uploading data from an arbitrary Apple Music API endpoint.
public struct MusicDataPostRequest {
  /// The URL for the data request.
  public var url: URL

  /// Creates a data request with the given URL.
  public init(url: URL) {
    self.url = url
  }

  /// Uploads data the Apple Music API endpoint that
  /// the URL request defines.
  public func response() async throws -> MusicDataResponse {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"

      let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
