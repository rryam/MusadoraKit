import Foundation

/// Supported periods for music summaries endpoint.
enum MSummaryPeriod: Equatable {
  case latestYear
  case month(year: Int, month: Int)

  static func latestMonth(
    calendar: Calendar = .init(identifier: .gregorian),
    now: Date = .now,
    timeZone: TimeZone = TimeZone(secondsFromGMT: 0) ?? .current
  ) -> MSummaryPeriod? {
    var calendar = calendar
    calendar.timeZone = timeZone

    guard let previousMonth = calendar.date(byAdding: .month, value: -1, to: now) else {
      return nil
    }

    let components = calendar.dateComponents([.year, .month], from: previousMonth)

    guard let year = components.year, let month = components.month else {
      return nil
    }

    return .month(year: year, month: month)
  }

  var resourcePath: String {
    switch self {
    case .latestYear:
      return "me/music-summaries"
    case let .month(year, month):
      return "me/music-summaries/month-\(year)-\(month)"
    }
  }

  var requiresLatestYearFilter: Bool {
    switch self {
    case .latestYear:
      return true
    case .month:
      return false
    }
  }
}
