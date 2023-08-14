//
//  MDataPutRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

/// A request structure for updating data at an arbitrary Apple Music API endpoint.
///
/// The `MDataPutRequest` struct facilitates sending PUT requests to the Apple Music API, allowing you to update existing resources,
/// such as modifying details of a playlist, changing track metadata, or any other action requiring a PUT request.
///
/// ### Usage Example:
///
/// ```swift
/// let playlistURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists/{id}")!
/// let updatedPlaylistData: Data = // ... (your encoded updated playlist data here)
/// let putRequest = MDataPutRequest(url: playlistURL, data: updatedPlaylistData)
///
/// do {
///     let response = try await putRequest.response()
///     print("Playlist updated successfully.")
/// } catch {
///     print("Failed to update playlist:", error.localizedDescription)
/// }
/// ```
/// 
public struct MDataPutRequest {

    /// The URL associated with the data request.
    private var url: URL

    /// The data payload to be uploaded for updating the resource.
    private var data: Data

    /// Initializes a new PUT data request using the specified URL and data payload.
    ///
    /// - Parameters:
    ///   - url: The URL representing the Apple Music API endpoint.
    ///   - data: The data payload to be used for updating the resource.
    public init(url: URL, data: Data) {
        self.url = url
        self.data = data
    }

    /// Sends a PUT request to the Apple Music API endpoint specified by the URL, using the provided data payload.
    ///
    /// - Returns: A `MusicDataResponse` object containing details about the outcome of the update operation.
    /// - Throws: An error if there's a problem initiating or receiving the PUT request.
    public func response() async throws -> MusicDataResponse {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.httpBody = data

        let request = MusicDataRequest(urlRequest: urlRequest)
        let response = try await request.response()
        return response
    }
}
