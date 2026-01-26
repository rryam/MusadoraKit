//
//  StationRow.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import SwiftUI

struct StationRow: View {
  var station: Station

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if let artwork = station.artwork {
          ArtworkImage(artwork, width: 100, height: 100)
            .cornerRadius(8)
        }

        Spacer()

        Image(systemName: "play.fill")
          .foregroundColor(.secondary)
          .onTapGesture {
            Task {
              do {
                try await APlayer.shared.play(station: station)
              } catch {
                ErrorPresenter.shared.present(error)
              }
            }
          }
      }

      Text(station.name)
        .bold()
        .font(.headline)

      Text("\(station.editorialNotes?.short ?? "") • \(station.editorialNotes?.standard ?? "")")
        .font(.subheadline)
    }
    .contentShape(Rectangle())
  }
}
