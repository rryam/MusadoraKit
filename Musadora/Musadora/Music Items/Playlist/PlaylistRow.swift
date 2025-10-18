//
//  PlaylistRow.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import SwiftUI

struct PlaylistRow: View {
  var playlist: Playlist

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if let artwork = playlist.artwork {
          ArtworkImage(artwork, width: 100, height: 100)
            .cornerRadius(8)
        }

        Spacer()

        Image(systemName: "play.fill")
          .foregroundColor(.secondary)
          .onTapGesture {
            Task {
              do {
                try await APlayer.shared.play(playlist: playlist)
              } catch {
                print(error)
              }
            }
          }
      }

      Text(playlist.name)
        .bold()
        .font(.headline)

      Text(playlist.curatorName ?? "")
        .font(.subheadline)
    }
    .contentShape(Rectangle())
  }
}
