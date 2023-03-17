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
      HStack {
        if let artwork = album.artwork {
          ArtworkImage(artwork, width: 100, height: 100)
            .cornerRadius(8)
        }

        Spacer()

        Image(systemName: "play.fill")
          .foregroundColor(.secondary)
          .onTapGesture {
            Task {
              do {
                try await APlayer.shared.play(album: album)
              } catch {
                print(error)
              }
            }
          }
      }

      Text(album.title)
        .bold()
        .font(.headline)

      Text(album.artistName)
        .font(.subheadline)
    }
    .contentShape(Rectangle())
  }
}
