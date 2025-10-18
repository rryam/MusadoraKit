//
//  SongsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import MusicKit
import SwiftUI

struct SongsView: View {
  private var songs: Songs
  @State private var favoritedSongIDs: Set<MusicItemID> = []
  @State private var favoritingSongIDs: Set<MusicItemID> = []

  init(with songs: Songs) {
    self.songs = songs
  }

  var body: some View {
    List {
      ForEach(songs.enumerated().map({ $0 }), id: \.element.id) { index, song in
        HStack(spacing: 12) {
          // Ranking number
          Text("\(index + 1)")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .frame(minWidth: 24)

          // Song artwork
          if let artwork = song.artwork {
            ArtworkImage(artwork, width: 50, height: 50)
              .cornerRadius(8)
          }

          // Song details
          VStack(alignment: .leading, spacing: 2) {
            Text(song.title)
              .font(.headline)
              .lineLimit(1)

            Text(song.artistName)
              .font(.subheadline)
              .foregroundColor(.secondary)
              .lineLimit(1)
          }

          Spacer()

          HStack(spacing: 16) {
            Button {
              Task {
                do {
                  try await APlayer.shared.play(song: song)
                } catch {
                  print(error)
                }
              }
            } label: {
              Image(systemName: "play.fill")
                .foregroundColor(.primary)
            }
            .buttonStyle(.plain)

            Button {
              guard favoritedSongIDs.contains(song.id) == false,
                    favoritingSongIDs.contains(song.id) == false else { return }

              Task {
                await MainActor.run { favoritingSongIDs.insert(song.id) }
                do {
                  if try await MCatalog.favorite(song: song) {
                    await MainActor.run { favoritedSongIDs.insert(song.id) }
                  }
                } catch {
                  print(error)
                }
                await MainActor.run { favoritingSongIDs.remove(song.id) }
              }
            } label: {
              let isFavorited = favoritedSongIDs.contains(song.id)
              Image(systemName: isFavorited ? "heart.fill" : "heart")
                .foregroundColor(isFavorited ? .red : .secondary)
            }
            .buttonStyle(.plain)
            .disabled(favoritingSongIDs.contains(song.id) || favoritedSongIDs.contains(song.id))
          }
        }
        .contentShape(Rectangle())
        .onTapGesture {
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
    .navigationTitle("Top Songs")
    .navigationBarTitleDisplayMode(.large)
  }
}
