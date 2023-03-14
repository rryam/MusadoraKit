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
          NavigationLink(destination: {
            PlaylistChartView(playlistChart: playlistChart)
          }, label: {
            Text(playlistChart.title)
          })
        }
      }

      Section("Songs Chart") {
        ForEach(chart?.songCharts ?? []) { songChart in
          NavigationLink(destination: {
            SongChartView(songChart: songChart)
          }, label: {
            Text(songChart.title)
          })
        }
      }

      Section("Albums Chart") {
        ForEach(chart?.albumCharts ?? []) { albumChart in
          NavigationLink(destination: {
            AlbumChartView(albumChart: albumChart)
          }, label: {
            Text(albumChart.title)
          })
        }
      }

      Section("Music Videos Chart") {
        ForEach(chart?.musicVideoCharts ?? []) { musicVideoChart in
          NavigationLink(destination: {
            MusicVideoChartView(musicVideoChart: musicVideoChart)
          }, label: {
            Text(musicVideoChart.title)
          })
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
