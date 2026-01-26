//
//  RecentlyPlayedView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import SwiftUI

struct RecentlyPlayedView: View {
  @State private var recentlyPlayedPlaylists: Playlists = []
  @State private var recentlyPlayedAlbums: Albums = []

  var body: some View {
    List {
      NavigationLink("Playlists", destination: PlaylistsView(with: recentlyPlayedPlaylists))
      NavigationLink("Albums", destination: AlbumsView(with: recentlyPlayedAlbums))
    }
    .navigationTitle("Recently Played")
    .task {
      do {
        recentlyPlayedAlbums = try await MHistory.recentlyPlayedAlbums(limit: 25, offset: 0)
        recentlyPlayedPlaylists = try await MHistory.recentlyPlayedPlaylists(limit: 25, offset: 0)
      } catch {
        print(error)
      }
    }
  }
}
