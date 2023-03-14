//
//  SongChartView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI
import MusicKit
import MusadoraKit

struct SongChartView: View {
  var songChart: MusicCatalogChart<Song>

  var body: some View {
    List {
      ForEach(songChart.items) { song in
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
        .onLongPressGesture(perform: { playItem(song) })
      }
    }
    .navigationTitle(songChart.title)
  }
}

extension SongChartView {
  private func playItem(_ song: Song) {
    Task {
      do {
        try await APlayer.shared.play(song: song)
      } catch {
        print(error)
      }
    }
  }
}
