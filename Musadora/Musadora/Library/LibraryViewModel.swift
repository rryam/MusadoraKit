//
//  LibraryViewModel.swift
//  Musadora
//
//  Created by Rudrank Riyam on 09/03/23.
//

import MusicKit
import MusadoraKit
import Combine

final class LibraryViewModel: ObservableObject {
  @Published private(set) var songs: Songs = []

  @MainActor public func fetchLibrarySongs() async {
    do {
      songs = try await MLibrary.songs()
    } catch {
      print("ERROR FETCHING LIBRARY SONGS.", error)
    }
  }
}
