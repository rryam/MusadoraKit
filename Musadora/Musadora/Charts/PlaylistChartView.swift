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
        .onLongPressGesture(perform: { playItem(playlist) })
      }
    }
    .navigationTitle(playlistChart.title)
  }
}

extension PlaylistChartView {
  private func playItem(_ playlist: Playlist) {
    Task {
      do {
        try await APlayer.shared.play(playlist: playlist)
      } catch {
        print(error)
      }
    }
  }
}
