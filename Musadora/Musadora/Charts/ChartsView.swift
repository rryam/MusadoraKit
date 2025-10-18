//
//  ChartsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import MusadoraKit
import SwiftUI

struct ChartsView: View {
  @State private var genres: Genres = []

#if os(iOS)
  private let columns = [GridItem(.flexible()), GridItem(.flexible())]
#else
  private let columns = [GridItem(.adaptive(minimum: 220))]
#endif

  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 12) {
          ForEach(genres) { genre in
            NavigationLink(destination: { ChartView(genre: genre) }, label: {
              Text(genre.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, minHeight: 80)
                .padding(12)
                .background(
                  RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                )
                .overlay(
                  RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.secondary.opacity(0.2))
                )
                .contentShape(RoundedRectangle(cornerRadius: 12))
            })
            .buttonStyle(.plain)
          }
        }
        .padding(.horizontal)
        .padding(.top)
      }
      .navigationTitle("Charts")
    }
    .task {
      do {
        genres = try await MCatalog.topGenres()
      } catch {
        print(error)
      }
    }
  }
}
