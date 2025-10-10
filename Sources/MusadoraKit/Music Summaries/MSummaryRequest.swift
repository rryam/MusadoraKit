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

    let request = MusicDataRequest(urlRequest: urlRequest)
    let response = try await request.response()

    let data = response.data

    do {
      return try MSummaryResponse.parse(from: data, using: decoder)
    } catch {
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
        // Default to including relationship names to get full objects instead of minimal resources
        queryItems.append(URLQueryItem(name: "include", value: "artist,album,song"))
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

/// Supported views for music summaries (Replay) API.
public enum MSummaryView: String, CaseIterable, Hashable {
  case topArtists = "top-artists"
  case topAlbums = "top-albums"
  case topSongs = "top-songs"
}
