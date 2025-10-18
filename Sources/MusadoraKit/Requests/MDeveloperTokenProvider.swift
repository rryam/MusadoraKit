//
//  MDeveloperTokenProvider.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 15/03/23.
//

import Foundation

/// A custom implementation of the `MusicTokenProvider` protocol for Apple Music API authentication.
///
/// The `MDeveloperTokenProvider` class facilitates generating **custom** developer tokens for Apple Music API authentication.
/// Unlike other potential implementations of `MusicTokenProvider`, this class directly takes and returns a **custom**
/// developer token, which can be useful in scenarios where the developer token doesn't need to be periodically refreshed
/// or generated dynamically.
///
/// Before making a request to Apple Music API, you can set the token provider of the request object using an instance of this class.
/// Doing so ensures that the API call is authenticated and adheres to the authorization standards of Apple Music API.
///
/// ### Usage Example:
///
/// ```swift
/// let developerTokenString = "YOUR_CUSTOM_DEVELOPER_TOKEN"
/// let tokenProvider = MDeveloperTokenProvider(developerToken: developerTokenString)
/// MusicDataRequest.tokenProvider = tokenProvider
///
/// // Now proceed with sending a MusicDataRequest
/// ```
///
@MainActor
public final class MDeveloperTokenProvider: MusicTokenProvider {
  /// The **custom** developer token used to authenticate Apple Music API requests.
  private var developerToken: String = ""

  /// Creates a new instance of `MDeveloperTokenProvider` using the provided **custom** developer token.
  ///
  /// - Parameter developerToken: The **custom** developer token for Apple Music API authentication.
  public convenience init(developerToken: String) {
    self.init()
    self.developerToken = developerToken
  }

  /// Fetches the **custom** developer token set during initialization.
  ///
  /// This method adheres to the `MusicTokenProvider` protocol but directly returns the **custom** developer token
  /// provided during object initialization without making any asynchronous calls or processing.
  ///
  /// - Parameter options: Options associated with the token request. This parameter is unused in this implementation
  ///                      as the token is provided directly without any dynamic generation.
  /// - Returns: The **custom** developer token as a string.
  public func developerToken(options: MusicTokenRequestOptions) async throws -> String {
    developerToken
  }
}
