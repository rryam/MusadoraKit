//
//  StationRow.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct StationRow: View {
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
    .contentShape(Rectangle())
    .onLongPressGesture {
      Task {
        do {
          try await APlayer.shared.play(station: station)
        } catch {
          print(error)
        }
      }
    }
  }
}
