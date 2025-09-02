//
//  MSummary.swift
//  MusadoraKit
//
//  Created by Codex on 02/09/25.
//

import Foundation

/// Structure containing the methods for accessing Apple Music "Replay" (music summaries) data.
///
/// `MSummary` provides access to the user's yearly music summary for the latest eligible year.
/// You can request the combined response or fetch top artists, albums, or songs directly.
public struct MSummary {}

// MARK: - Public API

public extension MSummary {
  /// Fetch the user's latest Replay summary for the specified views.
  /// - Parameters:
  ///   - views: Set of views to activate in the response. Defaults to all (`topArtists`, `topAlbums`, `topSongs`).
  ///   - languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  ///   - include: Optional relationship names to include.
  ///   - extend: Optional attribute extensions to apply.
  /// - Returns: A typed `MSummaryResponse` containing top artists, albums, and songs (when requested).
  static func latest(
    views: Set<MSummaryView> = [.topArtists, .topAlbums, .topSongs],
    languageTag: String? = nil,
    include: [String]? = nil,
    extend: [String]? = nil
  ) async throws -> MSummaryResponse {
    var request = MSummaryRequest()
    request.views = views
    request.languageTag = languageTag
    request.include = include
    request.extend = extend
    return try await request.response()
  }

  /// Convenience: Fetch only latest top artists.
  static func latestTopArtists(languageTag: String? = nil) async throws -> Artists {
    var request = MSummaryRequest()
    request.views = [.topArtists]
    request.languageTag = languageTag
    let response = try await request.response()
    return response.topArtists
  }

  /// Convenience: Fetch only latest top albums.
  static func latestTopAlbums(languageTag: String? = nil) async throws -> Albums {
    var request = MSummaryRequest()
    request.views = [.topAlbums]
    request.languageTag = languageTag
    let response = try await request.response()
    return response.topAlbums
  }

  /// Convenience: Fetch only latest top songs.
  static func latestTopSongs(languageTag: String? = nil) async throws -> Songs {
    var request = MSummaryRequest()
    request.views = [.topSongs]
    request.languageTag = languageTag
    let response = try await request.response()
    return response.topSongs
  }
}
