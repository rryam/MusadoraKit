//
//  MusadoraKit.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation
@_exported import MusicKit

/// MusadoraKit: The ultimate companion to MusicKit.
public struct MusadoraKit {}

/// There are five types of structures that you can use in your app.
/// You DON'T use the `MusadoraKit` structure anymore to access the
/// static methods.

/// The five types are:
/// 1. `MCatalog` for accessing the Apple Music catalog. (including catalog search)
/// 2. `MLibrary` for accessing the user's library . (including library search)
/// 3. `MRecommendation` for accessing the user's recommendations.
/// 4. `MHistory` for accessing historical data.
/// 5. `MRating` for working with ratings.

extension MusadoraKit {
    public static var userToken: String? {
        ProcessInfo.processInfo.environment["USER_TOKEN"]
    }
    
    /// Tests connectivity to the Apple Music API by sending a request to a dedicated test endpoint.
    ///
    /// This function performs a GET request to the `/v1/test` endpoint of the Apple Music API.
    /// If the request completes without throwing an error (specifically, receiving an HTTP 200 OK response),
    /// it signifies a successful connection.
    /// It helps verify that the application has a valid developer token and can reach the API.
    ///
    /// - Important: Ensure your app is properly configured with a valid developer token and necessary MusicKit capabilities before calling this.
    ///
    /// - Throws: An error if the connectivity test fails. Common errors include:
    ///   - `URLError.userAuthenticationRequired`: Thrown for an HTTP 401 Unauthorized response. This usually indicates an issue with the developer token or MusicKit setup. The `userInfo` dictionary contains a descriptive message.
    ///   - `URLError.badServerResponse`: Thrown for an HTTP 500 Internal Server Error or other unexpected status codes (like 404 Not Found, etc.). The `userInfo` dictionary contains a descriptive message including the status code.
    ///   - `URLError.badURL`: If the internal URL components fail to create a valid URL (should not typically happen).
    ///   - Other `URLError` codes may be thrown for underlying network issues (e.g., `URLError.cannotConnectToHost`, `URLError.timedOut`).
    ///
    /// - Returns: This function does not return a value upon successful connection. Success is indicated by the absence of a thrown error.
    ///
    /// ### Usage Example
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         try await MusadoraKit.testConnectivity()
    ///         print("Successfully connected to Apple Music API.")
    ///     } catch {
    ///         print("Failed to connect to Apple Music API: \\(error.localizedDescription)")
    ///         // Optionally inspect the userInfo for more details
    ///         if let urlError = error as? URLError, let description = urlError.userInfo["description"] as? String {
    ///             print("Details: \\(description)")
    ///         }
    ///     }
    /// }
    /// ```
    public static func testConnectivity() async throws {
        var components = AppleMusicURLComponents()
        components.path = "test"
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let request = MusicDataRequest(urlRequest: urlRequest)
        
        do {
            let response = try await request.response()
            
            let httpResponse = response.urlResponse
            
            switch httpResponse.statusCode {
            case 200:
                return
            case 401:
                throw URLError(.userAuthenticationRequired, userInfo: ["description": "Unauthorized (401). Check developer token validity and MusicKit setup."])
            case 500:
                throw URLError(.badServerResponse, userInfo: ["description": "Internal Server Error (500)."])
            default:
                throw URLError(.badServerResponse, userInfo: ["description": "Unexpected HTTP status code: \\(httpResponse.statusCode)"])
            }
        } catch let error as URLError where error.code == .userAuthenticationRequired {
            throw URLError(.userAuthenticationRequired, userInfo: ["description": "Unauthorized (401). Check developer token validity and MusicKit setup.", NSUnderlyingErrorKey: error])
        } catch {
            throw error
        }
    }
}
