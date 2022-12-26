//
//  MDataPutRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

struct MDataPutRequest {
  
  /// The URL for the data request.
  var url: URL

  /// Data to encode for the PUT request.
  var data: Data

  /// Creates a data request with the given URL.
  init(url: URL, data: Data) {
    self.url = url
    self.data = data
  }

  /// Uploads data the Apple Music API endpoint that
  /// the URL request defines.
  func response() async throws -> MusicDataResponse {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "PUT"
    urlRequest.httpBody = data

    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
