//
//  MTabView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 09/03/23.
//

import MusadoraKit
import SwiftUI

struct MTabView: View {
  var body: some View {
    TabView {
      RecommendationsView()
        .tabItem {
          Label("Recommendations", systemImage: "recordingtape")
        }

      CatalogView()
        .tabItem {
          Label("Catalog", systemImage: "music.note.list")
        }

      LibraryView()
        .tabItem {
          Label("Library", systemImage: "music.quarternote.3")
        }

      ChartsView()
        .tabItem {
          Label("Charts", systemImage: "chart.bar")
        }

      SettingsView()
        .tabItem {
          Label("Settings", systemImage: "gear")
        }
    }
    .welcomeSheet()
#if os(visionOS)
    .toolbar {
      ToolbarItemGroup(placement: .bottomOrnament) {
        PlayerControlView()
      }
    }
#endif
    .tint(.purple)
  }
}

struct PlayerControlView: View {
  @ObservedObject private var state = APlayer.shared.state
  var body: some View {
    HStack {
      AudioPlayerView()

      PlayerButton(image: "backward.fill") {
        try await APlayer.shared.skipToPreviousEntry()
      }

      PlayerButton(image: state.playbackStatus == .playing ? "pause.fill" : "play.fill") {
        if state.playbackStatus == .playing {
          APlayer.shared.pause()
        } else {
          try await APlayer.shared.play()
        }
      }

      PlayerButton(image: "forward.fill") {
        try await APlayer.shared.skipToNextEntry()
      }
    }
    .padding(.vertical, 8)
  }
}

struct AudioPlayerView: View {
  @ObservedObject private var queue = APlayer.shared.queue

  var body: some View {
    HStack {
      if let artwork = queue.currentEntry?.artwork {
        ArtworkImage(artwork, width: 80, height: 80)
          .scaledToFit()
          .cornerRadius(8)
      }

      VStack(alignment: .leading) {
        Text(queue.currentEntry?.title ?? "Placeholder title")
          .bold()

        Text(queue.currentEntry?.subtitle ?? "Placeholder subtitle")
          .font(.caption)
          .foregroundStyle(.tertiary)
      }
      .frame(width: 240, alignment: .leading)
    }
    .padding(.vertical, 7)
    .padding(.horizontal, 8)
  }
}

struct PlayerButton: View {
  let image: String
  let action: () async throws -> Void

  var body: some View {
    Button(action: {
      Task {
        do {
          try await action()
        } catch {
        }
      }
    }) {
      Image(systemName: image)
    }
  }
}

#Preview {
  PlayerControlView()
}
