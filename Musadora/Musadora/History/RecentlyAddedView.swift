//
//  RecentlyAddedView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct RecentlyAddedView: View {
  @State private var recentlyAddedItems: UserMusicItems = []
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
        recentlyAddedItems = try await MHistory.recentlyAdded(limit: 25, offset: 0)

        recentlyAddedPlaylists = MusicItemCollection(recentlyAddedItems.compactMap { item in
          guard case let .playlist(playlist) = item else { return nil }
          return playlist
        })

        recentlyAddedAlbums = MusicItemCollection(recentlyAddedItems.compactMap { item in
          guard case let .album(album) = item else { return nil }
          return album
        })
      } catch {
        print(error)
      }
    }
  }
}
