//
//  SettingsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 17/03/23.
//

import MusicKit
import SwiftUI

struct SettingsView: View {
  @State private var authStatus: MusicAuthorization.Status = MusicAuthorization.currentStatus
  @State private var canPlayCatalog: Bool?
  @State private var statusMessage: String?

  var body: some View {
    NavigationStack {
      List {
        Section("About") {
          Link("MusadoraKit on GitHub", destination: URL(string: "https://github.com/rryam/MusadoraKit")!)
          Link("Rudrank Riyam on X (Twitter)", destination: URL(string: "https://twitter.com/rudrankriyam")!)
        }

        Section("Authorization") {
          HStack {
            Text("Music Access")
            Spacer()
            Text(label(for: authStatus))
              .foregroundColor(authStatus == .authorized ? .secondary : .red)
          }

          if authStatus != .authorized {
            Button("Request Access") {
              Task { await requestAuthorization() }
            }
          }
        }

        Section("Subscription") {
          if let canPlayCatalog {
            HStack {
              Text("Apple Music")
              Spacer()
              Text(canPlayCatalog ? "Active" : "Inactive")
                .foregroundColor(canPlayCatalog ? .secondary : .red)
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
