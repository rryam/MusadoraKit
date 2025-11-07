//
//  MusicUserRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/02/24.
//

import Foundation
@preconcurrency import MusicKit

/// A request structure for fetching data from an arbitrary Apple Music API endpoint requiring user authentication.
///
/// The `MusicUserRequest` struct enables sending authenticated requests to the Apple Music API, incorporating user tokens for personalized actions.
/// The developer token is dynamically fetched using the token provider to ensure up-to-date authentication.
///
/// ### Usage Example:
///
/// ```swift
/// let playlistURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists")!
/// let urlRequest = URLRequest(url: playlistURL)
/// let userToken = "YOUR_USER_TOKEN"
/// let dataRequest = MusicUserRequest(urlRequest: urlRequest, userToken: userToken)
///
/// do {
///     let response = try await dataRequest.response()
///     print("Playlist data retrieved successfully:", String(data: response, encoding: .utf8) ?? "")
/// } catch {
///     print("Failed to retrieve playlist data:", error.localizedDescription)
/// }
/// ```
public struct MusicUserRequest {
  /// The user token used for personalized API requests.
  private let userToken: String

  /// The URL request configured for the API call.
  public var urlRequest: URLRequest

  /// Initializes a new data request with the specified URL request and user token.
  ///
  /// - Parameters:
  ///   - urlRequest: The URLRequest for the Apple Music API call.
  ///   - userToken: The user token for personalized requests.
  public init(urlRequest: URLRequest, userToken: String) {
    self.urlRequest = urlRequest
    self.userToken = userToken
  }

  /// Sends an authenticated request to the Apple Music API endpoint specified in the URL request.
  ///
  /// - Returns: The raw `Data` received in response to the API call.
  /// - Throws: An error if the request fails or if there's an issue with fetching the developer token.
  ///   Common errors include:
  ///   - `URLError.userAuthenticationRequired`: Thrown for HTTP 401 Unauthorized responses.
  ///   - `URLError.badServerResponse`: Thrown for HTTP 404 Not Found, 500 Internal Server Error, or other unexpected status codes.
  public func response() async throws -> Data {
    let developerToken = try await MusicDataRequest.tokenProvider.developerToken(options: .ignoreCache)

    var request = self.urlRequest
    request.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
    request.addValue(userToken, forHTTPHeaderField: "media-user-token")
    request.addValue("https://music.apple.com", forHTTPHeaderField: "Origin")
    request.addValue("https://music.apple.com/", forHTTPHeaderField: "Referer")

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse, userInfo: ["description": "Invalid HTTP response"])
    }

    switch httpResponse.statusCode {
    case 200:
      return data
    case 401:
      throw URLError(.userAuthenticationRequired, userInfo: ["description": "Unauthorized (401). Check user token validity and authentication."])
    case 404:
      throw URLError(.badServerResponse, userInfo: ["description": "Not Found (404). The requested resource does not exist."])
    case 500:
      throw URLError(.badServerResponse, userInfo: ["description": "Internal Server Error (500)."])
    default:
      throw URLError(.badServerResponse, userInfo: ["description": "Unexpected HTTP status code: \(httpResponse.statusCode)"])
    }
  }
}
