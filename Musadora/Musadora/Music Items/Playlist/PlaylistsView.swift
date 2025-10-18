//
//  PlaylistsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import SwiftUI

struct PlaylistsView: View {
  private var playlists: Playlists

  init(with playlists: Playlists) {
    self.playlists = playlists
  }

  var body: some View {
    List {
      ForEach(playlists, content: PlaylistRow.init)
    }
  }
}
