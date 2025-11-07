//
//  MusicCatalogRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 15/03/23.
//

import Foundation
@preconcurrency import MusicKit

/// A request structure for fetching data from the Apple Music API using developer tokens.
///
/// The `MusicDeveloperRequest` struct facilitates sending authenticated requests to the Apple Music API,
/// such as retrieving details of a playlist, fetching track metadata, or any other action requiring an API call.
///
/// Before sending a request, it sets a token provider with the provided developer token. This ensures that the API
/// call is authenticated and adheres to the authorization standards of Apple Music API.
///
/// ### Usage Example:
///
/// ```swift
/// let trackURL = URL(string: "https://api.music.apple.com/v1/catalog/us/songs/{id}")!
/// let urlRequest = URLRequest(url: trackURL)
/// let developerRequest = MusicDeveloperRequest(urlRequest: urlRequest, developerToken: "YOUR_DEVELOPER_TOKEN")
///
/// do {
///     let response = try await developerRequest.response()
///     print("Track data retrieved successfully:", response)
/// } catch {
///     print("Failed to retrieve track data:", error.localizedDescription)
/// }
/// ```
///
public struct MusicDeveloperRequest: Sendable {
  /// The developer token used for authentication with the Apple Music API.
  private let developerToken: String

  /// The URL request used to specify details for the API call, such as endpoint, method, and headers.
  public let urlRequest: URLRequest

  /// Initializes a new data request using the specified URL request and developer token.
  ///
  /// - Parameters:
  ///   - urlRequest: The URLRequest representing the Apple Music API call.
  ///   - developerToken: The developer token used for authentication.
  public init(urlRequest: URLRequest, developerToken: String) {
    self.urlRequest = urlRequest
    self.developerToken = developerToken
  }

  /// Sends a request to the Apple Music API endpoint specified by the URL request.
  ///
  /// This method uses the provided developer token to set a token provider, ensuring the API call is authenticated.
  ///
  /// - Returns: A `MusicDataResponse` object containing the outcome of the API call.
  /// - Throws: An error if there's a problem initiating or receiving the response.
  public func response() async throws -> MusicDataResponse {
    let token = self.developerToken
    MusicDataRequest.tokenProvider = await MDeveloperTokenProvider(developerToken: token)
    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
