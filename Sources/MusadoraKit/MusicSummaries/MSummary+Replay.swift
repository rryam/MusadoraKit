// 
//  MSummaryReplay.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 14/10/25.
//

import Foundation

// MARK: - Replay (Music Summaries)

public extension MSummary {
  /// Fetch the user's latest Replay summary for the specified views.

  /// - Parameters:
  ///   - views: Set of views to activate in the response. Defaults to all (`topArtists`, `topAlbums`, `topSongs`).
  ///   - languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  ///   - include: Optional relationship names to include.
  ///   - extend: Optional attribute extensions to apply.
  /// - Returns: A typed `MusicSummaryResponse` containing top artists, albums, and songs (when requested).
  static func latest(
    views: Set<MusicSummaryView> = [.topArtists, .topAlbums, .topSongs],
    languageTag: String? = nil,
    include: [String]? = nil,
    extend: [String]? = nil
  ) async throws -> MusicSummaryResponse {
    let request = requestForLatest(
      views: views,
      languageTag: languageTag,
      include: include,
      extend: extend
    )
    return try await request.response()
  }

  /// Fetch the user's latest monthly Replay summary (previous calendar month).

  /// - Parameters:
  ///   - views: Set of views to activate in the response. Defaults to all (`topArtists`, `topAlbums`, `topSongs`).
  ///   - languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  ///   - include: Optional relationship names to include.
  ///   - extend: Optional attribute extensions to apply.
  /// - Returns: A typed `MusicSummaryResponse` containing top artists, albums, and songs (when requested) for the latest month.
  /// - Throws: `MusadoraKitError.invalidSummaryPeriod` when a valid previous month cannot be determined from the provided context.
  static func latestMonth(
    views: Set<MusicSummaryView> = [.topArtists, .topAlbums, .topSongs],
    languageTag: String? = nil,
    include: [String]? = nil,
    extend: [String]? = nil,
    calendar: Calendar = .init(identifier: .gregorian),
    now: Date = .now,
    timeZone: TimeZone = TimeZone(secondsFromGMT: 0) ?? .current
  ) async throws -> MusicSummaryResponse {
    let context = LatestMonthContext(calendar: calendar, now: now, timeZone: timeZone)
    let request = try requestForLatestMonth(
      views: views,
      languageTag: languageTag,
      include: include,
      extend: extend,
      context: context
    )
    return try await request.response()
  }

  /// Fetch the user's latest Replay top artists for the most recent eligible year.
  ///
  /// - Parameter languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  /// - Returns: The ordered list of top artists from the user's latest Replay summary.
  static func latestTopArtists(languageTag: String? = nil) async throws -> Artists {
    try await response(for: .latestYear, views: [.topArtists], languageTag: languageTag).topArtists
  }

  /// Fetch the user's latest monthly Replay top artists (previous calendar month).
  ///
  /// - Parameters:
  ///   - languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  ///   - calendar: Calendar instance used when determining the reference month. Defaults to Gregorian.
  ///   - now: Current date used to calculate the previous month. Defaults to system time.
  ///   - timeZone: Time zone used when computing month boundaries. Defaults to GMT.
  /// - Returns: The ordered list of top artists for the user's most recent monthly Replay summary.
  /// - Throws: `MusadoraKitError.invalidSummaryPeriod` when a valid previous month cannot be determined from the provided context.
  static func latestMonthTopArtists(
    languageTag: String? = nil,
    calendar: Calendar = .init(identifier: .gregorian),
    now: Date = .now,
    timeZone: TimeZone = TimeZone(secondsFromGMT: 0) ?? .current
  ) async throws -> Artists {
    guard let period = MusicSummaryPeriod.latestMonth(calendar: calendar, now: now, timeZone: timeZone) else {
      throw MusadoraKitError.invalidSummaryPeriod
    }

    return try await response(
      for: period,
      views: [.topArtists],
      languageTag: languageTag
    ).topArtists
  }

  /// Fetch the user's latest Replay top albums for the most recent eligible year.
  ///
  /// - Parameter languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  /// - Returns: The ordered list of top albums from the user's latest Replay summary.
  static func latestTopAlbums(languageTag: String? = nil) async throws -> Albums {
    try await response(for: .latestYear, views: [.topAlbums], languageTag: languageTag).topAlbums
  }

  /// Fetch the user's latest monthly Replay top albums (previous calendar month).
  ///
  /// - Parameters:
  ///   - languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  ///   - calendar: Calendar instance used when determining the reference month. Defaults to Gregorian.
  ///   - now: Current date used to calculate the previous month. Defaults to system time.
  ///   - timeZone: Time zone used when computing month boundaries. Defaults to GMT.
  /// - Returns: The ordered list of top albums for the user's most recent monthly Replay summary.
  /// - Throws: `MusadoraKitError.invalidSummaryPeriod` when a valid previous month cannot be determined from the provided context.
  static func latestMonthTopAlbums(
    languageTag: String? = nil,
    calendar: Calendar = .init(identifier: .gregorian),
    now: Date = .now,
    timeZone: TimeZone = TimeZone(secondsFromGMT: 0) ?? .current
  ) async throws -> Albums {
    guard let period = MusicSummaryPeriod.latestMonth(calendar: calendar, now: now, timeZone: timeZone) else {
      throw MusadoraKitError.invalidSummaryPeriod
    }

    return try await response(
      for: period,
      views: [.topAlbums],
      languageTag: languageTag
    ).topAlbums
  }

  /// Fetch the user's latest Replay top songs for the most recent eligible year.
  ///
  /// - Parameter languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  /// - Returns: The ordered list of top songs from the user's latest Replay summary.
  static func latestTopSongs(languageTag: String? = nil) async throws -> Songs {
    try await response(for: .latestYear, views: [.topSongs], languageTag: languageTag).topSongs
  }

  /// Fetch the user's latest monthly Replay top songs (previous calendar month).
  ///
  /// - Parameters:
  ///   - languageTag: Optional BCP‑47 language tag. If not provided, storefront default is used.
  ///   - calendar: Calendar instance used when determining the reference month. Defaults to Gregorian.
  ///   - now: Current date used to calculate the previous month. Defaults to system time.
  ///   - timeZone: Time zone used when computing month boundaries. Defaults to GMT.
  /// - Returns: The ordered list of top songs for the user's most recent monthly Replay summary.
  /// - Throws: `MusadoraKitError.invalidSummaryPeriod` when a valid previous month cannot be determined from the provided context.
  static func latestMonthTopSongs(
    languageTag: String? = nil,
    calendar: Calendar = .init(identifier: .gregorian),
    now: Date = .now,
    timeZone: TimeZone = TimeZone(secondsFromGMT: 0) ?? .current
  ) async throws -> Songs {
    guard let period = MusicSummaryPeriod.latestMonth(calendar: calendar, now: now, timeZone: timeZone) else {
      throw MusadoraKitError.invalidSummaryPeriod
    }

    return try await response(
      for: period,
      views: [.topSongs],
      languageTag: languageTag
    ).topSongs
  }
}

extension MSummary {
  internal struct LatestMonthContext {
    let calendar: Calendar
    let now: Date
    let timeZone: TimeZone

    init(
      calendar: Calendar = .init(identifier: .gregorian),
      now: Date = .now,
      timeZone: TimeZone = TimeZone(secondsFromGMT: 0) ?? .current
    ) {
      self.calendar = calendar
      self.now = now
      self.timeZone = timeZone
    }
  }

  internal static func requestForLatest(
    views: Set<MusicSummaryView>,
    languageTag: String?,
    include: [String]?,
    extend: [String]?
  ) -> MusicSummaryRequest {
    makeRequest(
      period: .latestYear,
      views: views,
      languageTag: languageTag,
      include: include,
      extend: extend
    )
  }

  internal static func requestForLatestMonth(
    views: Set<MusicSummaryView>,
    languageTag: String?,
    include: [String]?,
    extend: [String]?,
    context: LatestMonthContext
  ) throws -> MusicSummaryRequest {
    guard let period = MusicSummaryPeriod.latestMonth(
      calendar: context.calendar,
      now: context.now,
      timeZone: context.timeZone
    ) else {
      throw MusadoraKitError.invalidSummaryPeriod
    }

    return makeRequest(
      period: period,
      views: views,
      languageTag: languageTag,
      include: include,
      extend: extend
    )
  }

  private static func response(
    for period: MusicSummaryPeriod,
    views: Set<MusicSummaryView>,
    languageTag: String?,
    include: [String]? = nil,
    extend: [String]? = nil
  ) async throws -> MusicSummaryResponse {
    let request = makeRequest(
      period: period,
      views: views,
      languageTag: languageTag,
      include: include,
      extend: extend
    )
    return try await request.response()
  }

  internal static func makeRequest(
    period: MusicSummaryPeriod,
    views: Set<MusicSummaryView>,
    languageTag: String?,
    include: [String]? = nil,
    extend: [String]? = nil
  ) -> MusicSummaryRequest {
    var request = MusicSummaryRequest()
    request.period = period
    request.views = views
    request.languageTag = languageTag
    request.include = include
    request.extend = extend
    return request
  }
}
