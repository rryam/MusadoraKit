//
//  RecommendationView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import MusadoraKit
import SwiftUI

struct RecommendationView: View {
  var recommendation: MusicRecommendationItem

  var body: some View {
    ScrollView(.horizontal) {
      LazyHStack {
        ForEach(recommendation.items, content: RecommendationRow.init)
      }
    }
  }
}

struct RecommendationRow: View {
  var item: UserMusicItem

  var body: some View {
    Button(action: {
      Task {
        do {
          APlayer.shared.queue = [item]
          try await APlayer.shared.play()
        } catch {
          print(error)
        }
      }
    }, label: {
      VStack(alignment: .leading) {
        if let artwork = item.artwork {
          ArtworkImage(artwork, width: 250, height: 250)
            .cornerRadius(16)
        } else {
          Color.red
        }

        Text(item.title)
          .bold()
          .font(.headline)
      }
      .padding(8)
      .contentShape(RoundedRectangle(cornerRadius: 24))
      #if os(visionOS)
      .hoverEffect()
      #endif
    })
    .buttonStyle(.plain)
  }
}
