//
//  RecommendationsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 13/03/23.
//

import SwiftUI
import MusadoraKit
import MusicKit

struct RecommendationsView: View {
  @State private var recommendations: PersonalRecommendations = []
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(recommendations) { recommendation in
          NavigationLink(destination: {
            RecommendationView(recommendation: recommendation)
          }, label: {
            Text(recommendation.title ?? "")
          })
        }
      }
      .navigationTitle("Recommendations")
    }
    .onAppear {
      fetchRecommendations()
    }
  }
}

extension RecommendationsView {
  private func fetchRecommendations() {
    Task {
      do {
        recommendations = try await MRecommendation.personal()
      } catch {
        print(error)
      }
    }
  }
}
