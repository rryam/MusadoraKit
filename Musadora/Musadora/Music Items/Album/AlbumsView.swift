//
//  AlbumsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct AlbumsView: View {
  private var albums: Albums

  init(with albums: Albums) {
    self.albums = albums
  }

  var body: some View {
    List {
      ForEach(albums, content: AlbumRow.init)
    }
  }
}
