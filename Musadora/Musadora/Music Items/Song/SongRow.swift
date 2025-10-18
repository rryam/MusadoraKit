//
//  SongRow.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import SwiftUI

struct SongRow: View {
  @State private var isFavorited = false
  @State private var isFavoriting = false
  var song: Song

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if let artwork = song.artwork {
          ArtworkImage(artwork, width: 100, height: 100)
            .cornerRadius(8)
        }

        Spacer()

        HStack(spacing: 16) {
          Image(systemName: "play.fill")
            .foregroundColor(.secondary)
            .onTapGesture {
              Task {
                do {
                  try await APlayer.shared.play(song: song)
                } catch {
                  print(error)
                }
              }
            }

          Button {
            guard !isFavorited, !isFavoriting else { return }
            Task {
              await MainActor.run { isFavoriting = true }
              do {
                let success = try await MCatalog.favorite(song: song)
                if success {
                  await MainActor.run { isFavorited = true }
                }
              } catch {
                print(error)
              }
              await MainActor.run { isFavoriting = false }
            }
          } label: {
            Image(systemName: isFavorited ? "heart.fill" : "heart")
              .foregroundColor(isFavorited ? .red : .secondary)
          }
          .buttonStyle(.plain)
          .disabled(isFavoriting || isFavorited)
        }
      }

      Text(song.title)
        .bold()
        .font(.headline)

      Text(song.artistName)
        .font(.subheadline)
    }
    .contentShape(Rectangle())
  }
}
