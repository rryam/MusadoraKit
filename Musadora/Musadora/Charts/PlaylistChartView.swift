//
//  PlaylistChartView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI

import MusadoraKit

struct PlaylistChartView: View {
  var playlistChart: MusicCatalogChart<Playlist>

  var body: some View {
    List {
      ForEach(playlistChart.items) { playlist in
        VStack(alignment: .leading) {
          HStack {
            if let artwork = playlist.artwork {
              ArtworkImage(artwork, width: 100, height: 100)
                .cornerRadius(8)
            }

            Spacer()

            Button(action: {
              Task {
                do {
                  try await APlayer.shared.play(playlist: playlist)
                } catch {
                  print(error)
                }
              }
            }, label: {
              Image(systemName: "play.fill")
            })
            .buttonStyle(.plain)
          }

          Text(playlist.name)
            .bold()
            .font(.headline)

          Text(playlist.curatorName ?? "")
            .font(.subheadline)
        }
      }
    }
    .navigationTitle(playlistChart.title)
  }
}
