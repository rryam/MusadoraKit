//
//  MusicDataPutRequest.swift
//  MusicDataPutRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public struct MusicDataPutRequest {
  /// The URL for the data request.
  public var url: URL

  /// Data to encode for the PUT request.
  public var data: Data

  /// Creates a data request with the given URL.
  public init(url: URL, data: Data) {
    self.url = url
    self.data = data
  }

  /// Uploads data the Apple Music API endpoint that
  /// the URL request defines.
  public func response() async throws -> MusicDataResponse {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "PUT"
    urlRequest.httpBody = data

    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
