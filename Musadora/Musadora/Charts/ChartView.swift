//
//  ChartView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import MusadoraKit
import SwiftUI

struct ChartView: View {
  var genre: Genre

  @State private var chart: MusicCatalogChartsResponse?

#if os(iOS)
  private let columns = [GridItem(.flexible()), GridItem(.flexible())]
#else
  private let columns = [GridItem(.adaptive(minimum: 220))]
#endif

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        if let playlistCharts = chart?.playlistCharts, !playlistCharts.isEmpty {
          Text("Playlists")
            .font(.title2).bold()
            .padding(.horizontal)

          LazyVGrid(columns: columns, spacing: 12) {
            ForEach(playlistCharts) { playlistChart in
              NavigationLink(destination: { PlaylistChartView(playlistChart: playlistChart) }, label: {
                ChartTile(title: playlistChart.title)
              })
              .buttonStyle(.plain)
            }
          }
          .padding(.horizontal)
        }

        if let songCharts = chart?.songCharts, !songCharts.isEmpty {
          Text("Songs")
            .font(.title2).bold()
            .padding(.horizontal)

          LazyVGrid(columns: columns, spacing: 12) {
            ForEach(songCharts) { songChart in
              NavigationLink(destination: { SongChartView(songChart: songChart) }, label: {
                ChartTile(title: songChart.title)
              })
              .buttonStyle(.plain)
            }
          }
          .padding(.horizontal)
        }

        if let albumCharts = chart?.albumCharts, !albumCharts.isEmpty {
          Text("Albums")
            .font(.title2).bold()
            .padding(.horizontal)

          LazyVGrid(columns: columns, spacing: 12) {
            ForEach(albumCharts) { albumChart in
              NavigationLink(destination: { AlbumChartView(albumChart: albumChart) }, label: {
                ChartTile(title: albumChart.title)
              })
              .buttonStyle(.plain)
            }
          }
          .padding(.horizontal)
        }

        if let musicVideoCharts = chart?.musicVideoCharts, !musicVideoCharts.isEmpty {
          Text("Music Videos")
            .font(.title2).bold()
            .padding(.horizontal)

          LazyVGrid(columns: columns, spacing: 12) {
            ForEach(musicVideoCharts) { videoChart in
              NavigationLink(destination: { MusicVideoChartView(musicVideoChart: videoChart) }, label: {
                ChartTile(title: videoChart.title)
              })
              .buttonStyle(.plain)
            }
          }
          .padding(.horizontal)
        }
      }
      .padding(.vertical)
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

private struct ChartTile: View {
  let title: String

  var body: some View {
    Text(title)
      .font(.headline)
      .multilineTextAlignment(.center)
      .frame(maxWidth: .infinity, minHeight: 80)
      .padding(12)
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.gray.opacity(0.1))
      )
      .overlay(
        RoundedRectangle(cornerRadius: 12)
          .stroke(Color.secondary.opacity(0.2))
      )
      .contentShape(RoundedRectangle(cornerRadius: 12))
  }
}
