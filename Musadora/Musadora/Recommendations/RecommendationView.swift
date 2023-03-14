//
//  RecommendationView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI
import MusadoraKit
import MusicKit

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
      if let artwork = item.artwork {
        ArtworkImage(artwork, width: 80, height: 80)
          .cornerRadius(8)
      }

      Text(item.title)
        .bold()
        .font(.headline)

      Text(item.subtitle ?? "")
        .font(.subheadline)
    }
    .onLongPressGesture(perform: { playItem(item) })
  }
}

extension RecommendationRow {
  private func playItem(_ item: MusicPersonalRecommendation.Item) {
    Task {
      do {
        try await APlayer.shared.play(item: item)
      } catch {
        print(error)
      }
    }
  }
}
