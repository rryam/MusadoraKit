//
//  MusicSummariesView.swift
//  Musadora
//
//  Created by Codex on 02/09/25.
//

import SwiftUI
import MusadoraKit

struct MusicSummariesView: View {
  @State private var topArtists: Artists = []
  @State private var topAlbums: Albums = []
  @State private var topSongs: Songs = []
  @State private var year: Int?

  var body: some View {
    List {
      if let year {
        Text("Year: \(year)")
          .font(.headline)
      }

      NavigationLink("Top Songs", destination: SongsView(with: topSongs))
      NavigationLink("Top Albums", destination: AlbumsView(with: topAlbums))

      Section("Top Artists") {
        ForEach(topArtists) { artist in
          Text(artist.name)
        }
      }
    }
    .navigationTitle("Music Summaries")
    .task {
      do {
        let summary = try await MSummary.latest()
        self.topArtists = summary.topArtists
        self.topAlbums = summary.topAlbums
        self.topSongs = summary.topSongs
        self.year = summary.year
      } catch {
        print(error)
      }
    }
  }
}

