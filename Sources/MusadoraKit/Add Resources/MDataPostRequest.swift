//
//  MDataPostRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation
import MusicKit

/// A request for uploading data from an arbitrary Apple Music API endpoint.
public struct MDataPostRequest {

  /// The URL for the data request.
  private var url: URL

  /// Data to encode for the POST request.
  private var data: Data?

  /// Creates a data request with the given URL.
  public init(url: URL, data: Data? = nil) {
    self.url = url
    self.data = data
  }

  /// Uploads data the Apple Music API endpoint that
  /// the URL request defines.
  public func response() async throws -> MusicDataResponse {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = data

    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
