//
//  MDataDeleteRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// A request for deleting data for an arbitrary Apple Music API endpoint.
public struct MDataDeleteRequest {
  
  /// The URL for the data request.
  private var url: URL
  
  /// Creates a data request with the given URL.
  public init(url: URL) {
    self.url = url
  }
  
  /// Delete data for the Apple Music API endpoint that
  /// the URL request defines.
  public func response() async throws -> MusicDataResponse {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"
    
    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
