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
    NavigationListStack("Charts") {
      ForEach(genres) { genre in
        NavigationLink(genre.name, destination: ChartView(genre: genre))
      }
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

struct NavigationListStack<Content>: View where Content: View {
  var title: String
  var content: () -> Content

  init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
    self.title = title
    self.content = content
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        content()
      }
      .navigationTitle(title)
    }
  }
}
