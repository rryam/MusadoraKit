//
//  LibraryView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 09/03/23.
//

import SwiftUI
import MusadoraKit
import MusicKit

struct LibraryView: View {
  @StateObject private var viewModel = LibraryViewModel()

  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        LazyVGrid(columns: [.init(), .init()]) {
          ForEach(viewModel.songs) { song in
            VStack {
              AsyncImage(url: song.artwork?.url(width: 200, height: 200), content: { (image) in
                image
                  .resizable()
                  .cornerRadius(12)
                  .frame(width: 150, height: 150)
                  .transition(.opacity)
              }, placeholder: {
                LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                  .cornerRadius(12)
                  .frame(width: 150, height: 150)
                  .transition(.opacity)
              })

              Text(song.title)
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 200)
            }
            .contentShape(Rectangle())
            .onTapGesture {
              Task {
                do {
                  try await APlayer.shared.play(song: song)
                } catch {
                  print("CANNOT PLAY SONG \(song.title)", error)
                }
              }
            }
          }
        }
      }
      .navigationTitle("Library")
      .task {
        await viewModel.fetchLibrarySongs()
      }
    }
  }
}
