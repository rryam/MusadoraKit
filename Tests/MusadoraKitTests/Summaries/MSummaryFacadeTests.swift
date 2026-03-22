import Foundation
@testable import MusadoraKit
import Testing

@Suite
struct MSummaryFacadeTests {
  @Test
  func latestRequestUsesDefaults() throws {
    let request = MSummary.requestForLatest(
      views: [.topAlbums, .topArtists, .topSongs],
      languageTag: nil,
      include: nil,
      extend: nil
    )

    #expect(request.period == .latestYear)
    #expect(request.views == [.topAlbums, .topArtists, .topSongs])
    #expect(request.languageTag == nil)
    #expect(request.include == nil)
    #expect(request.extend == nil)
  }

  @Test
  func latestMonthRequestBuildsExpectedPeriod() throws {
    let calendar = Calendar(identifier: .gregorian)
    let timeZone = TimeZone(secondsFromGMT: 0) ?? .current
    var components = DateComponents()
    components.calendar = calendar
    components.timeZone = timeZone
    components.year = 2025
    components.month = 2
    components.day = 15
    let now = try #require(components.date)

    let context = MSummary.LatestMonthContext(
      calendar: calendar,
      now: now,
      timeZone: timeZone
    )
    let request = try MSummary.requestForLatestMonth(
      views: [.topSongs],
      languageTag: "en-US",
      include: ["relationships"],
      extend: ["extended-attributes"],
      context: context
    )

    #expect(request.period == .month(year: 2025, month: 1))
    #expect(request.views == [.topSongs])
    #expect(request.languageTag == "en-US")
    #expect(request.include == ["relationships"])
    #expect(request.extend == ["extended-attributes"])
  }

  @Test
  func latestMonthPeriodRespectsRequestedTimeZoneAtBoundary() throws {
    let calendar = Calendar(identifier: .gregorian)
    let utc = try #require(TimeZone(secondsFromGMT: 0))
    let india = try #require(TimeZone(identifier: "Asia/Kolkata"))

    var components = DateComponents()
    components.calendar = calendar
    components.timeZone = utc
    components.year = 2026
    components.month = 2
    components.day = 28
    components.hour = 19
    components.minute = 0

    let now = try #require(components.date)

    #expect(MusicSummaryPeriod.latestMonth(calendar: calendar, now: now, timeZone: utc) == .month(year: 2026, month: 1))
    #expect(MusicSummaryPeriod.latestMonth(calendar: calendar, now: now, timeZone: india) == .month(year: 2026, month: 2))
  }
}
