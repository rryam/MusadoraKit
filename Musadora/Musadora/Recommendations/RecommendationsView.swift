//
//  RecommendationsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 13/03/23.
//

import SwiftUI
import MusadoraKit

struct RecommendationsView: View {
  @State private var recommendations: PersonalRecommendations = []
  
  var body: some View {
    NavigationListStack("Recommendations") {
      ForEach(recommendations) { recommendation in
        NavigationLink(destination: {
          RecommendationView(recommendation: recommendation)
        }, label: {
          Text(recommendation.title ?? "")
        })
      }
    }
    .task {
      do {
        recommendations = try await MRecommendation.personal()
      } catch {
        print(error)
      }
    }
  }
}
