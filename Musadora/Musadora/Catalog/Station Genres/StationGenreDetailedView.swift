//
//  StationGenreDetailedView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 12/03/23.
//

import SwiftUI
import MusadoraKit
import MusicKit

struct StationGenreDetailedView: View {
  var stationGenre: StationGenre

  @State private var stations: Stations = []

  var body: some View {
    List {
      ForEach(stations) { station in
        StationGenreDetailedRow(station: station)
      }
      .navigationTitle(stationGenre.name)
    }
    .onAppear {
      fetchStation(for: stationGenre)
    }
  }
}

extension StationGenreDetailedView {
  private func fetchStation(for stationGenre: StationGenre) {
    Task {
      do {
        stations = try await MCatalog.stations(for: stationGenre)
      } catch {
        print(error)
      }
    }
  }
}

struct StationGenreDetailedRow: View {
  var station: Station

  var body: some View {
    VStack(alignment: .leading) {
      if let artwork = station.artwork {
        ArtworkImage(artwork, width: 80, height: 80)
          .cornerRadius(8)
      }

      Text(station.name)
        .bold()
        .font(.headline)

      Text("\(station.editorialNotes?.short ?? "") • \(station.editorialNotes?.standard ?? "")")
        .font(.subheadline)
    }
    .onLongPressGesture(perform: { playStation(station) })
  }
}

extension StationGenreDetailedRow {
  private func playStation(_ station: Station) {
    Task {
      do {
        try await APlayer.shared.play(station: station)
      } catch {
        print(error)
      }
    }
  }
}
