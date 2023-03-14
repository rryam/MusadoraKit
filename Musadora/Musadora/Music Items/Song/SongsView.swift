//
//  SongsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct SongsView: View {
  private var songs: Songs

  init(with songs: Songs) {
    self.songs = songs
  }

  var body: some View {
    List {
      ForEach(songs, content: SongRow.init)
    }
  }
}
