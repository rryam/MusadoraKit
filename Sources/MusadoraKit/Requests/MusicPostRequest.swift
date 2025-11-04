//
//  MusicPostRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

import Foundation

/// A request structure for uploading data to the Apple Music API using developer tokens.
///
/// This struct provides a way to send POST requests to the Apple Music API. You can use it to upload data,
/// such as adding songs to a library, creating new playlists, or any other action that requires a POST request.
///
/// ### Usage Example:
///
/// ```swift
/// let playlistURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists")!
/// let playlistData: Data = // ... (your encoded playlist data here)
/// let postRequest = MusicPostRequest(url: playlistURL, data: playlistData)
///
/// do {
///     let response = try await postRequest.response()
///     print("Playlist added successfully.")
/// } catch {
///     print("Failed to add playlist:", error.localizedDescription)
/// }
/// ```
///
public struct MusicPostRequest: Sendable {
  /// The URL associated with the data request.
  var url: URL

  /// The data payload to be uploaded using the POST request.
  var data: Data?

  /// Creates a POST data request based on the specified URL and data payload.
  ///
  /// - Parameters:
  ///   - url: The URL representing the Apple Music API endpoint.
  ///   - data: The data payload to be uploaded. Defaults to `nil`.
  public init(url: URL, data: Data? = nil) {
    self.url = url
    self.data = data
  }

  /// Sends a POST request to the Apple Music API endpoint specified by the URL, using the provided data payload.
  ///
  /// - Returns: A `MusicDataResponse` object containing details about the outcome of the post operation.
  /// - Throws: An error if there's a problem initiating or receiving the post request.
  public func response() async throws -> MusicDataResponse {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = data

    if data != nil && urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    if let userToken = MusadoraKit.userToken {
      urlRequest.setValue(userToken, forHTTPHeaderField: "Music-User-Token")
    }

    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
