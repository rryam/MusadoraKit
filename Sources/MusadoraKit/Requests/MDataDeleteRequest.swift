//
//  MDataDeleteRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// A request structure for deleting data from an arbitrary Apple Music API endpoint.
///
/// This structure provides a way to send DELETE requests to the Apple Music API,
/// such as removing items from playlists or deleting user-created playlists.
///
/// Example usage:
/// ```swift
/// // Delete a playlist from the user's library
/// let playlistURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists/p.12345")!
/// let deleteRequest = MDataDeleteRequest(url: playlistURL)
///
/// do {
///     let response = try await deleteRequest.response()
///     print("Successfully deleted playlist")
/// } catch {
///     print("Failed to delete playlist: \(error)")
/// }
/// ```
///
public struct MDataDeleteRequest {

  /// The URL associated with the data request.
  private var url: URL

  /// Creates a data request for deletion based on the specified URL.
  ///
  /// - Parameter url: The URL representing the Apple Music API endpoint.
  public init(url: URL) {
    self.url = url
  }

  /// Sends a DELETE request to the Apple Music API endpoint specified by the URL.
  ///
  /// - Returns: A `MusicDataResponse` object containing details about the outcome of the delete operation.
  /// - Throws: An error if there's a problem initiating or receiving the delete request.
  public func response() async throws -> MusicDataResponse {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"

    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()
    return response
  }
}
