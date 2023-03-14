//
//  LibraryPlaylistsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct LibraryPlaylistsView: View {
  @State private var playlists: Playlists = []

  var body: some View {
    PlaylistsView(with: playlists)
      .navigationTitle("Playlists")
      .task {
        do {
          playlists = try await MLibrary.playlists()
        } catch {
          print(error)
        }
      }
  }
}
