//
//  SongRow.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct SongRow: View {
  var song: Song

  var body: some View {
    VStack(alignment: .leading) {
      if let artwork = song.artwork {
        ArtworkImage(artwork, width: 80, height: 80)
          .cornerRadius(8)
      }

      Text(song.title)
        .bold()
        .font(.headline)

      Text(song.artistName)
        .font(.subheadline)
    }
    .contentShape(Rectangle())
    .onLongPressGesture {
      Task {
        do {
          try await APlayer.shared.play(song: song)
        } catch {
          print(error)
        }
      }
    }
  }
}
