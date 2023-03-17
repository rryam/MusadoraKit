//
//  RecommendationView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI
import MusadoraKit


struct RecommendationView: View {
  var recommendation: MusicPersonalRecommendation

  var body: some View {
    List {
      ForEach(recommendation.items, content: RecommendationRow.init)
    }
    .navigationTitle(recommendation.title ?? "")
  }
}

struct RecommendationRow: View {
  var item: MusicPersonalRecommendation.Item

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if let artwork = item.artwork {
          ArtworkImage(artwork, width: 100, height: 100)
            .cornerRadius(8)
        }

        Spacer()

        Image(systemName: "play.fill")
          .foregroundColor(.secondary)
          .onTapGesture {
            Task {
              do {
                try await APlayer.shared.play(item: item)
              } catch {
                print(error)
              }
            }
          }
      }

      Text(item.title)
        .bold()
        .font(.headline)

      Text(item.subtitle ?? "")
        .font(.subheadline)
    }
  }
}
