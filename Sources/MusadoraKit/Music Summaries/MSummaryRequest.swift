//
//  MSummaryRequest.swift
//  MusadoraKit
//
//  Created by Codex on 02/09/25.
//

import Foundation

/// A request that your app uses to fetch the user's Apple Music summary (Replay) for the latest eligible year.
struct MSummaryRequest {
  /// Views to activate in the response.
  var views: Set<MSummaryView> = [.topArtists, .topAlbums, .topSongs]

  /// Optional language tag (BCP‑47) to localize the response.
  var languageTag: String?

  /// Optional include relationships.
  var include: [String]?

  /// Optional attribute extensions to apply.
  var extend: [String]?

  /// Builds and performs the request, returning a parsed summary response.
  func response() async throws -> MSummaryResponse {
    let url = try endpointURL

    // Decoder configured for documented date formats
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    // Build and send request
    let urlRequest = URLRequest(url: url)

    #if DEBUG
    debugPrint("[MSummary] Request URL: \(url.absoluteString)")
    if let comps = URLComponents(url: url, resolvingAgainstBaseURL: false) {
      debugPrint("[MSummary] Query Items: \(comps.queryItems?.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&") ?? "<none>")")
    }
    #endif

    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()

    #if DEBUG
    if let http = response.urlResponse as? HTTPURLResponse {
      debugPrint("[MSummary] Response Status: \(http.statusCode)")
      debugPrint("[MSummary] Response Headers: \(http.allHeaderFields)")
    }
    #endif

    let data = response.data

    #if DEBUG
    if let pretty = MSummaryDebug.prettyJSONString(from: data) {
      debugPrint("[MSummary] Raw JSON (pretty):\n\(pretty)")
    } else if let raw = String(data: data, encoding: .utf8) {
      debugPrint("[MSummary] Raw Body (utf8):\n\(raw)")
    } else {
      debugPrint("[MSummary] Raw Body: <non-utf8 data of \(data.count) bytes>")
    }
    #endif

    do {
      return try MSummaryResponse.parse(from: data, using: decoder)
    } catch {
      #if DEBUG
      debugPrint("[MSummary] Decoding Error: \(String(describing: error))")
      #endif
      throw error
    }
  }
}

extension MSummaryRequest {
  /// Constructs the endpoint URL for the music summaries request.
  var endpointURL: URL {
    get throws {
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem] = []

      components.path = "me/music-summaries"

      // Required per docs: filter[year]=latest
      queryItems.append(URLQueryItem(name: "filter[year]", value: "latest"))

      if !views.isEmpty {
        let value = views.map { $0.rawValue }.sorted().joined(separator: ",")
        queryItems.append(URLQueryItem(name: "views", value: value))
      }

      if let include, !include.isEmpty {
        queryItems.append(URLQueryItem(name: "include", value: include.joined(separator: ",")))
      } else {
        // Default to including relationship data to get full objects instead of minimal resources
        queryItems.append(URLQueryItem(name: "include", value: "top-artists,top-albums,top-songs"))
      }

      if let extend, !extend.isEmpty {
        queryItems.append(URLQueryItem(name: "extend", value: extend.joined(separator: ",")))
      } else {
        // Default to extending all available attributes for richer data
        queryItems.append(URLQueryItem(name: "extend", value: "artistBio,editorialVideo"))
      }

      if let languageTag, !languageTag.isEmpty {
        queryItems.append(URLQueryItem(name: "l", value: languageTag))
      }

      components.queryItems = queryItems

      guard let url = components.url else { throw URLError(.badURL) }
      return url
    }
  }
}

// MARK: - Debug helpers

#if DEBUG
enum MSummaryDebug {
  static func prettyJSONString(from data: Data) -> String? {
    guard let obj = try? JSONSerialization.jsonObject(with: data, options: []),
          JSONSerialization.isValidJSONObject(obj) || obj is [Any] || obj is [String: Any] else {
      // Even if it isn't a canonical JSON object/array, try pretty printing if possible
      if let obj = try? JSONSerialization.jsonObject(with: data, options: []) {
        let pretty = try? JSONSerialization.data(withJSONObject: obj, options: [.prettyPrinted, .sortedKeys])
        return pretty.flatMap { String(data: $0, encoding: .utf8) }
      }
      return nil
    }
    let pretty = try? JSONSerialization.data(withJSONObject: obj, options: [.prettyPrinted, .sortedKeys])
    return pretty.flatMap { String(data: $0, encoding: .utf8) }
  }
}
#endif

/// Supported views for music summaries (Replay) API.
public enum MSummaryView: String, CaseIterable, Hashable {
  case topArtists = "top-artists"
  case topAlbums = "top-albums"
  case topSongs = "top-songs"
}
