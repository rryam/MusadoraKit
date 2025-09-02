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
    NavigationStack {
      List {
        Section("Library") {
          NavigationLink("Songs") { LibrarySongsView() }
          NavigationLink("Albums") { LibraryAlbumsView() }
          NavigationLink("Playlists") { LibraryPlaylistsView() }
        }

        Section("History") {
          NavigationLink("Recently Added") { RecentlyAddedView() }
          NavigationLink("Recently Played") { RecentlyPlayedView() }
          NavigationLink("Music Summaries") { MusicSummariesView() }
        }
      }
      .navigationTitle("Library")
    }
  }
}
