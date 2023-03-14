//
//  ChartsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 14/03/23.
//

import SwiftUI
import MusadoraKit

struct ChartsView: View {
  @State private var genres: Genres = []

  var body: some View {
    NavigationStack {
      List {
        ForEach(genres) { genre in
          NavigationLink(destination: {
            ChartView(genre: genre)
          }, label: {
            Text(genre.name)
          })
        }
      }
      .navigationTitle("Charts")
    }
    .onAppear {
      fetchGenres()
    }
  }
}

extension ChartsView {
  private func fetchGenres() {
    Task {
      do {
        genres = try await MCatalog.topGenres()
      } catch {
        print(error)
      }
    }
  }
}

struct ChartsView_Previews: PreviewProvider {
  static var previews: some View {
    ChartsView()
  }
}
