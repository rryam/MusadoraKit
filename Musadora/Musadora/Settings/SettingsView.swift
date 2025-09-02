//
//  SettingsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 17/03/23.
//

import SwiftUI
import MusicKit

struct SettingsView: View {
  @State private var authStatus: MusicAuthorization.Status = MusicAuthorization.currentStatus
  @State private var canPlayCatalog: Bool? = nil
  @State private var statusMessage: String? = nil

  var body: some View {
    NavigationStack {
      List {
        Section("About") {
          Text("Made for [MusadoraKit](https://github.com/rryam/MusadoraKit). Go ⭐️ it!")
          Text("Made by [Rudrank Riyam](https://twitter.com/rudrankriyam). Go follow him!")
        }

        Section("Authorization") {
          LabeledContent("Music Access") {
            Text(label(for: authStatus))
              .foregroundStyle(authStatus == .authorized ? .secondary : .red)
          }

          if authStatus != .authorized {
            Button("Request Access") {
              Task { await requestAuthorization() }
            }
          }
        }

        Section("Subscription") {
          if let canPlayCatalog {
            LabeledContent("Apple Music") {
              Text(canPlayCatalog ? "Active" : "Inactive")
                .foregroundStyle(canPlayCatalog ? .secondary : .red)
            }
          } else {
            ProgressView().frame(maxWidth: .infinity, alignment: .leading)
          }
        }

        if let statusMessage {
          Section {
            Text(statusMessage).foregroundStyle(.secondary)
          }
        }
      }
      .navigationTitle("Settings")
    }
    .tint(.indigo)
    .task { await refreshStatus() }
  }
}

extension SettingsView {
  private func label(for status: MusicAuthorization.Status) -> String {
    switch status {
    case .authorized: return "Authorized"
    case .denied: return "Denied"
    case .notDetermined: return "Not Determined"
    case .restricted: return "Restricted"
    @unknown default: return "Unknown"
    }
  }

  @MainActor
  private func refreshStatus() async {
    authStatus = MusicAuthorization.currentStatus
    let subscription: MusicSubscription? = try? await MusicSubscription.current
    canPlayCatalog = subscription?.canPlayCatalogContent
  }

  @MainActor
  private func requestAuthorization() async {
    let status = await MusicAuthorization.request()
    authStatus = status
    await refreshStatus()
    if status != .authorized {
      statusMessage = "Please grant access in Settings to enable Apple Music features."
    } else {
      statusMessage = nil
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
