//
//  ChartView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI
import MusadoraKit


struct ChartView: View {
  var genre: Genre

  @State private var chart: MusicCatalogChartsResponse?

  var body: some View {
    List {
      Section("Playlists Chart") {
        ForEach(chart?.playlistCharts ?? []) { playlistChart in
          NavigationLink(playlistChart.title, destination: PlaylistChartView(playlistChart: playlistChart))
        }
      }

      Section("Songs Chart") {
        ForEach(chart?.songCharts ?? []) { songChart in
          NavigationLink(songChart.title, destination: SongChartView(songChart: songChart))
        }
      }

      Section("Albums Chart") {
        ForEach(chart?.albumCharts ?? []) { albumChart in
          NavigationLink(albumChart.title, destination: AlbumChartView(albumChart: albumChart))
        }
      }

      Section("Music Videos Chart") {
        ForEach(chart?.musicVideoCharts ?? []) { musicVideoChart in
          NavigationLink(musicVideoChart.title, destination: MusicVideoChartView(musicVideoChart: musicVideoChart))
        }
      }
    }
    .navigationTitle(genre.name)
    .task {
      await fetchChart()
    }
  }
}

extension ChartView {
  private func fetchChart() async {
    do {
      chart = try await MCatalog.charts(genre: genre, kinds: .all, types: .all)
    } catch {
      print(error)
    }
  }
}
