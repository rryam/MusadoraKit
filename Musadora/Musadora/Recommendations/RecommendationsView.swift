//
//  RecommendationsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 13/03/23.
//

import SwiftUI
import MusadoraKit

struct RecommendationsView: View {
  @State private var recommendations: MRecommendations = []

  var body: some View {
    NavigationListStack("Recommendations") {
      ForEach(recommendations) { recommendation in
        VStack {
          Text(recommendation.title ?? "")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)

          RecommendationView(recommendation: recommendation)
        }
      }
      .padding(.horizontal)
    }
    .task {
      do {
        // User recommendations(userToken:) to debug in simulator
        recommendations = try await MRecommendation.default()
      } catch {
        print(error)
      }
    }
  }
}
