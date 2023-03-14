//
//  AlbumChartView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI
import MusicKit
import MusadoraKit

struct AlbumChartView: View {
  var albumChart: MusicCatalogChart<Album>

  var body: some View {
    List {
      ForEach(albumChart.items) { album in
        VStack(alignment: .leading) {
          if let artwork = album.artwork {
            ArtworkImage(artwork, width: 80, height: 80)
              .cornerRadius(8)
          }

          Text(album.title)
            .bold()
            .font(.headline)

          Text(album.artistName)
            .font(.subheadline)
        }
        .onLongPressGesture(perform: { playItem(album) })
      }
    }
  }
}

extension AlbumChartView {
  private func playItem(_ album: Album) {
    Task {
      do {
        try await APlayer.shared.play(album: album)
      } catch {
        print(error)
      }
    }
  }
}
