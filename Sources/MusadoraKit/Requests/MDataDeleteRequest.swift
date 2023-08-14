//
//  MDataDeleteRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// A request structure for deleting data from an arbitrary Apple Music API endpoint.
///
/// ### Usage Example:
///
/// ```swift
/// let playlistURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists/{id}")!
/// let deleteRequest = MDataDeleteRequest(url: playlistURL)
///
/// do {
///     let response = try await deleteRequest.response()
///     print("Playlist deleted successfully.")
/// } catch {
///     print("Failed to delete playlist:", error.localizedDescription)
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
