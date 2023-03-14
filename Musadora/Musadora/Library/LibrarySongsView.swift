//
//  LibrarySongsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct LibrarySongsView: View {
  @State private var songs: Songs = []

  var body: some View {
    SongsView(with: songs)
      .navigationTitle("Songs")
      .task {
        do {
          songs = try await MLibrary.songs()
        } catch {
          print(error)
        }
      }
  }
}
