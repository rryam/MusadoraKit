//
//  SongChartView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI

import MusadoraKit

struct SongChartView: View {
  var songChart: MusicCatalogChart<Song>

  var body: some View {
    SongsView(with: songChart.items)
      .navigationTitle(songChart.title)
  }
}
