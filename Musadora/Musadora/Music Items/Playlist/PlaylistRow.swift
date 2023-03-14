//
//  PlaylistRow.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct PlaylistRow: View {
  var playlist: Playlist

  var body: some View {
    VStack(alignment: .leading) {
      if let artwork = playlist.artwork {
        ArtworkImage(artwork, width: 80, height: 80)
          .cornerRadius(8)
      }

      Text(playlist.name)
        .bold()
        .font(.headline)

      Text(playlist.curatorName ?? "")
        .font(.subheadline)
    }
    .contentShape(Rectangle())
    .onLongPressGesture {
      Task {
        do {
          try await APlayer.shared.play(playlist: playlist)
        } catch {
          print(error)
        }
      }
    }
  }
}
