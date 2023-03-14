//
//  MusicVideoChartView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI

import SwiftUI

import MusadoraKit

struct MusicVideoChartView: View {
  var musicVideoChart: MusicCatalogChart<MusicVideo>

  var body: some View {
    List {
      ForEach(musicVideoChart.items) { musicVideo in
        VStack(alignment: .leading) {
          if let artwork = musicVideo.artwork {
            ArtworkImage(artwork, width: 80, height: 80)
              .cornerRadius(8)
          }

          Text(musicVideo.title)
            .bold()
            .font(.headline)

          Text(musicVideo.artistName)
            .font(.subheadline)
        }
      }
    }
    .navigationTitle(musicVideoChart.title)
  }
}
