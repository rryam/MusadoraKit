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

/// There are four facade structures that you typically reach for instead of the `MusadoraKit`
/// type itself. Each exposes static methods tailored to a specific area:
/// 1. `MCatalog` for accessing the Apple Music catalog (search, storefronts, charts, ratings, favorites, etc.)
/// 2. `MLibrary` for interacting with the user's library (fetch, search, add/remove content, ratings)
/// 3. `MRecommendation` for working with Apple Music recommendations (including 100 Best Albums support)
/// 4. `MHistory` for accessing historical data (recently played/added)
///
/// Rating operations are provided via extensions on `MCatalog` and `MLibrary` in the `Ratings` module.

extension MusadoraKit {
    private static let userTokenKey = "com.musadorakit.userToken"

    /// The user token for authentication.
    public static var userToken: String? {
        get {
            UserDefaults.standard.string(forKey: userTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userTokenKey)
        }
    }

    /// Tests connectivity to the Apple Music API by sending a request to a dedicated test endpoint.
    ///
    /// It helps verify that the application has a valid developer token and can reach the API.
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
    ///         try await MusadoraKit.test()
    ///         print("Successfully connected to Apple Music API.")
    ///     } catch {
    ///         print("Failed to connect to Apple Music API: \(error.localizedDescription)")
    ///     }
    /// }
    /// ```
    public static func test() async throws {
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
                throw URLError(.badServerResponse, userInfo: ["description": "Unexpected HTTP status code: \(httpResponse.statusCode)"])
            }
        } catch let error as URLError where error.code == .userAuthenticationRequired {
            throw URLError(.userAuthenticationRequired, userInfo: ["description": "Unauthorized (401). Check developer token validity and MusicKit setup.", NSUnderlyingErrorKey: error])
        } catch {
            throw error
        }
    }

}
