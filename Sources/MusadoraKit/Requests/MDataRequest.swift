//
//  MDataRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 15/03/23.
//

import Foundation

/// A custom request for loading data from an arbitrary Apple Music API endpoint.
public struct MDataRequest {

  /// The developer token for Apple Music API.
  private let developerToken: String

  /// The URL request for the data request.
  public let urlRequest: URLRequest

  /// Creates a data request with a URL request.
  public init(urlRequest: URLRequest, developerToken: String) {
    self.urlRequest = urlRequest
    self.developerToken = developerToken
  }

  /// Fetches data from the Apple Music API endpoint that
  /// the URL request defines.
  public func response() async throws -> MusicDataResponse {
    MusicDataRequest.tokenProvider = MDeveloperTokenProvider(developerToken: developerToken)
    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
