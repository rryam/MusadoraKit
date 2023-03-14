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
        NavigationLink(destination: {
          ChartView(genre: genre)
        }, label: {
          Text(genre.name)
        })
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
      List {
        content()
      }
      .navigationTitle(title)
    }
  }
}
