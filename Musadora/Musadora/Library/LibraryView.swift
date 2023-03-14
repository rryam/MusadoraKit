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
      NavigationLink(destination: {
        LibrarySongsView()
      }, label: {
        Text("Songs")
      })

      NavigationLink(destination: {
        LibraryAlbumsView()
      }, label: {
        Text("Albums")
      })

      NavigationLink(destination: {
        LibraryPlaylistsView()
      }, label: {
        Text("Playlists")
      })
    }
  }
}
