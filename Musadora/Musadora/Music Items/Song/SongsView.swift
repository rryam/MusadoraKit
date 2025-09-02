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
          
          // Play button
          Button(action: {
            Task {
              do {
                try await APlayer.shared.play(song: song)
              } catch {
                print(error)
              }
            }
          }) {
            Image(systemName: "play.fill")
              .foregroundColor(.primary)
          }
          .buttonStyle(PlainButtonStyle())
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
