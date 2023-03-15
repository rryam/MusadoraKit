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
      NavigationLink("Songs", destination: LibrarySongsView())
      NavigationLink("Albums", destination: LibraryAlbumsView())
      NavigationLink("Playlists", destination: LibraryPlaylistsView())
    }
  }
}
