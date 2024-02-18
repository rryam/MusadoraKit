//
//  MTabView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 09/03/23.
//

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
    .tint(.purple)
  }
}
