//
//  StationGenreDetailedView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 12/03/23.
//

import MusadoraKit
import SwiftUI

struct StationGenreDetailedView: View {
  var stationGenre: StationGenre

  @State private var stations: Stations = []

  var body: some View {
    List {
      ForEach(stations) { station in
        StationRow(station: station)
      }
      .navigationTitle(stationGenre.name)
    }
    .task {
      do {
        stations = try await MCatalog.stations(for: stationGenre)
      } catch {
        print(error)
      }
    }
  }
}
