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
      LibraryView()
        .tabItem {
          Label("Library", systemImage: "music.quarternote.3")
        }
    }
    .welcomeSheet()
    .tint(.purple)
  }
}
