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
  @State private var topArtists: Artists = []
  @State private var topAlbums: Albums = []
  @State private var topSongs: Songs = []
  @State private var year: Int?
  @State private var errorMessage: String?
  @State private var isEligible: Bool = false

  var body: some View {
    List {
      if let message = errorMessage {
        Section {
          Text(message)
            .foregroundStyle(.secondary)
        }
      }

      if isEligible {
        if let year {
          Text("Year: \(year)")
            .font(.headline)
        }

        NavigationLink("Top Songs", destination: SongsView(with: topSongs))
        NavigationLink("Top Albums", destination: AlbumsView(with: topAlbums))

        Section("Top Artists") {
          ForEach(topArtists) { artist in
            Text(artist.name)
          }
        }
      }
    }
    .navigationTitle("Music Summaries")
    .task(id: MusicAuthorization.currentStatus) {
      await checkEligibilityAndLoad()
    }
  }
}

extension MusicSummariesView {
  @MainActor
  private func checkEligibilityAndLoad() async {
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

    do {
      let summary = try await MSummary.latest()
      self.topArtists = summary.topArtists
      self.topAlbums = summary.topAlbums
      self.topSongs = summary.topSongs
      self.year = summary.year
      self.isEligible = true
    } catch is CancellationError {
      // Task was cancelled by SwiftUI lifecycle; ignore
    } catch {
      errorMessage = "Could not load Replay (\(error.localizedDescription))."
    }
  }
}
