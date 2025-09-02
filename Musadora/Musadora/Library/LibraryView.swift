//
//  LibraryView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 09/03/23.
//

import SwiftUI
import MusadoraKit

struct LibraryView: View {
  var body: some View {
    NavigationListStack("Library") {
      Section("Library") {
        NavigationLink("Songs", destination: LibrarySongsView())
        NavigationLink("Albums", destination: LibraryAlbumsView())
        NavigationLink("Playlists", destination: LibraryPlaylistsView())
      }

      Section("History") {
        NavigationLink("Recently added", destination: RecentlyAddedView())
        NavigationLink("Recently played", destination: RecentlyPlayedView())
        NavigationLink("Music Summaries", destination: MusicSummariesView())
      }
    }
  }
}
