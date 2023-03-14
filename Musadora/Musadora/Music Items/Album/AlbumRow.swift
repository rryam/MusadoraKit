//
//  AlbumRow.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct AlbumRow: View {
  var album: Album

  var body: some View {
    VStack(alignment: .leading) {
      if let artwork = album.artwork {
        ArtworkImage(artwork, width: 80, height: 80)
          .cornerRadius(8)
      }

      Text(album.title)
        .bold()
        .font(.headline)

      Text(album.artistName)
        .font(.subheadline)
    }
    .contentShape(Rectangle())
    .onLongPressGesture {
      Task {
        do {
          try await APlayer.shared.play(album: album)
        } catch {
          print(error)
        }
      }
    }
  }
}
