//
//  MusicDataDeleteRequest.swift
//  MusicDataDeleteRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
import MusicKit

public struct MDataDeleteRequest {
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
    urlRequest.httpMethod = "DELETE"
    
    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
