//
//  LibraryAlbumsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import SwiftUI

struct LibraryAlbumsView: View {
  @State private var albums: Albums = []

  var body: some View {
    AlbumsView(with: albums)
      .navigationTitle("Albums")
      .task {
        do {
          albums = try await MLibrary.albums()
        } catch {
          print(error)
        }
      }
  }
}
