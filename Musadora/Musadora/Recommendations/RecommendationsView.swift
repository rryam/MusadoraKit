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
  @State private var hundredBestAlbums: [HundredBestAlbum] = []

  var body: some View {
    NavigationListStack("Recommendations") {

      Section("100 Best Albums") {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 20) {
          ForEach(hundredBestAlbums) { album in
            Button(action: {
              Task {
                let detailedAlbum = try await MCatalog.album(id: album.id, fetch: .tracks)
                try await APlayer.shared.play(album: detailedAlbum)
              }
            }, label: {
              VStack {
                ArtworkImage(album.artwork, width: 200, height: 200)
                  .cornerRadius(16)

                Text(album.title)
                  .font(.title2)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.top)
                  .lineLimit(1)

                Text(album.artistName)
                  .font(.headline)
                  .foregroundColor(.secondary)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .lineLimit(1)
              }
              .padding()
            })
          }
        }
        .padding(.horizontal)
      }

      Section("Personal") {
        ForEach(recommendations) { recommendation in
          VStack {
            Text(recommendation.title ?? "")
              .font(.title2)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.top)

            RecommendationView(recommendation: recommendation)
          }
        }
      }
      .padding(.horizontal)
    }
    .task {
      do {
        // User recommendations(userToken:) to debug in simulator
        hundredBestAlbums = try await MRecommendation.allHundredBestAlbums()
        recommendations = try await MRecommendation.default()
      } catch {
        print(error)
      }
    }
  }
}
