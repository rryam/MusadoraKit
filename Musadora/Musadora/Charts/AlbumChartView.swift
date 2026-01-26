//
//  AlbumChartView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI

import MusadoraKit

struct AlbumChartView: View {
  var albumChart: MusicCatalogChart<Album>

  var body: some View {
    List {
      ForEach(albumChart.items) { album in
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
                    ErrorPresenter.shared.present(error)
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
      }
    }
  }
}
