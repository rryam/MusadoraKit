//
//  RecentlyAddedView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import SwiftUI

struct RecentlyAddedView: View {
  @State private var recentlyAddedPlaylists: Playlists = []
  @State private var recentlyAddedAlbums: Albums = []

  var body: some View {
    List {
      NavigationLink("Playlists", destination: PlaylistsView(with: recentlyAddedPlaylists))
      NavigationLink("Albums", destination: AlbumsView(with: recentlyAddedAlbums))
    }
    .navigationTitle("Recently Added")
    .task {
      do {
        recentlyAddedPlaylists = try await MHistory.recentlyAddedPlaylists(limit: 25, offset: 0)
        recentlyAddedAlbums = try await MHistory.recentlyAddedAlbums(limit: 25, offset: 0)
      } catch {
        print(error)
      }
    }
  }
}
