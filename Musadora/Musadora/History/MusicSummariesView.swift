//
//  MusicSummariesView.swift
//  Musadora
//
//  Created by Codex on 02/09/25.
//

import SwiftUI
import MusadoraKit
import MusicKit

struct MusicSummariesView: View {
  @State private var selection: SummarySelection = .year
  @State private var topArtists: Artists = []
  @State private var topAlbums: Albums = []
  @State private var topSongs: Songs = []
  @State private var title: String = ""
  @State private var subtitle: String?
  @State private var isEligible: Bool = false
  @State private var isLoading: Bool = false
  @State private var errorMessage: String?

  var body: some View {
    List {
      Picker("Summary Period", selection: $selection) {
        ForEach(SummarySelection.allCases) { period in
          Text(period.title)
            .tag(period)
        }
      }
      .pickerStyle(.segmented)
      .padding(.vertical, 4)

      if isLoading {
        ProgressView("Loading Replay…")
          .frame(maxWidth: .infinity)
      }

      if let message = errorMessage {
        Section {
          Text(message)
            .foregroundStyle(.secondary)
        }
      }

      if isEligible {
        if !title.isEmpty {
          VStack(alignment: .leading, spacing: 4) {
            Text(title)
              .font(.headline)
            if let subtitle {
              Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
          }
        }

        NavigationLink("Top Songs", destination: SongsView(with: topSongs))
        NavigationLink("Top Albums", destination: AlbumsView(with: topAlbums))

        Section("Top Artists") {
          if topArtists.isEmpty {
            Text("No artists in this summary.")
              .foregroundStyle(.secondary)
          } else {
            ForEach(topArtists) { artist in
              Text(artist.name)
            }
          }
        }
      }
    }
    .navigationTitle("Music Summaries")
    .task(id: MusicAuthorization.currentStatus) {
      await checkEligibilityAndLoad()
    }
    .task(id: selection) {
      await loadSummaries()
    }
  }
}

private extension MusicSummariesView {
  enum SummarySelection: String, CaseIterable, Identifiable {
    case year
    case month

    var id: String { rawValue }

    var title: String {
      switch self {
      case .year:
        "Year"
      case .month:
        "Month"
      }
    }
  }

  @MainActor
  func checkEligibilityAndLoad() async {
    errorMessage = nil
    isEligible = false

    // Do not start request until authorized
    let status = MusicAuthorization.currentStatus
    guard status == .authorized else {
      errorMessage = "Not authorized for Apple Music. Tap Continue on the welcome screen."
      return
    }

    // Ensure user has an active Apple Music subscription
    let subscription: MusicSubscription? = try? await MusicSubscription.current
    guard subscription?.canPlayCatalogContent == true else {
      errorMessage = "Requires an active Apple Music subscription to load Replay."
      return
    }

    await loadSummaries()
  }

  @MainActor
  func loadSummaries() async {
    guard !isLoading else { return }

    errorMessage = nil

    isLoading = true
    defer { isLoading = false }

    do {
      let summary: MSummaryResponse
      switch selection {
      case .year:
        summary = try await MSummary.latest()
        if let year = summary.year {
          title = "Year: \(year)"
          subtitle = "Apple Music Replay"
        } else {
          title = "Latest Replay"
          subtitle = "Yearly summary"
        }
      case .month:
        summary = try await MSummary.latestMonth()
        title = "Latest Month"
        subtitle = "Apple Music Replay (Monthly)"
      }

      topArtists = summary.topArtists
      topAlbums = summary.topAlbums
      topSongs = summary.topSongs
      isEligible = true
    } catch is CancellationError {
      // Task was cancelled by SwiftUI lifecycle; ignore
    } catch let error as MusadoraKitError {
      switch error {
      case .invalidSummaryPeriod:
        errorMessage = "Monthly Replay isn't available for the previous month yet. Try again soon."
      default:
        errorMessage = "Could not load Replay (\(error.localizedDescription))."
      }
      topArtists = []
      topAlbums = []
      topSongs = []
      isEligible = false
    } catch {
      errorMessage = "Could not load Replay (\(error.localizedDescription))."
      topArtists = []
      topAlbums = []
      topSongs = []
      isEligible = false
    }
  }
}
