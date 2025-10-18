//
//  AlbumsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import MusadoraKit
import MusicKit
import SwiftUI

struct AlbumsView: View {
  private var albums: Albums
  @State private var favoritedAlbumIDs: Set<MusicItemID> = []
  @State private var favoritingAlbumIDs: Set<MusicItemID> = []

  init(with albums: Albums) {
    self.albums = albums
  }

  var body: some View {
    ScrollView {
      LazyVStack(spacing: 20) {
        if albums.count > 4 {
          // Show top 4 in grid
          VStack(alignment: .leading, spacing: 16) {
            Text("Top Albums")
              .font(.title2)
              .fontWeight(.bold)
              .padding(.horizontal)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
              ForEach(albums.prefix(4), id: \.id) { album in
                AlbumGridCard(
                  album: album,
                  isFavorited: favoritedAlbumIDs.contains(album.id),
                  isFavoriting: favoritingAlbumIDs.contains(album.id),
                  onPlay: { play(album: album) },
                  onFavorite: { favorite(album: album) }
                )
              }
            }
            .padding(.horizontal)
          }

          // Show remaining albums in list
          if albums.count > 4 {
            VStack(alignment: .leading, spacing: 12) {
              Text("All Albums")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.top)

              LazyVStack(spacing: 8) {
                ForEach(albums, content: AlbumRow.init)
              }
              .padding(.horizontal)
            }
          }
        } else {
          // Show all albums in grid if 4 or fewer
          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
            ForEach(albums, id: \.id) { album in
              AlbumGridCard(
                album: album,
                isFavorited: favoritedAlbumIDs.contains(album.id),
                isFavoriting: favoritingAlbumIDs.contains(album.id),
                onPlay: { play(album: album) },
                onFavorite: { favorite(album: album) }
              )
            }
          }
          .padding(.horizontal)
        }
      }
    }
    .navigationTitle("Top Albums")
    .navigationBarTitleDisplayMode(.large)
  }
}

struct AlbumGridCard: View {
  let album: Album
  let isFavorited: Bool
  let isFavoriting: Bool
  let onPlay: () -> Void
  let onFavorite: () -> Void

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if let artwork = album.artwork {
        ArtworkImage(artwork, width: 150, height: 150)
          .cornerRadius(12)
          .overlay(alignment: .topTrailing) {
            Button(action: onFavorite) {
              Image(systemName: isFavorited ? "heart.circle.fill" : "heart.circle")
                .font(.title3)
                .foregroundColor(isFavorited ? .red : .primary)
            }
            .buttonStyle(.plain)
            .disabled(isFavoriting || isFavorited)
            .padding(8)
          }
      }

      VStack(alignment: .leading, spacing: 4) {
        Text(album.title)
          .font(.headline)
          .lineLimit(2)

        Text(album.artistName)
          .font(.subheadline)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    }
    .onTapGesture {
      onPlay()
    }
  }
}

@MainActor
private extension AlbumsView {
  func play(album: Album) {
    Task {
      do {
        try await APlayer.shared.play(album: album)
      } catch {
        print(error)
      }
    }
  }

  func favorite(album: Album) {
    guard favoritedAlbumIDs.contains(album.id) == false,
          favoritingAlbumIDs.contains(album.id) == false else { return }

    Task {
      await MainActor.run { favoritingAlbumIDs.insert(album.id) }
      do {
        if try await MCatalog.favorite(album: album) {
          await MainActor.run { favoritedAlbumIDs.insert(album.id) }
        }
      } catch {
        print(error)
      }
      await MainActor.run { favoritingAlbumIDs.remove(album.id) }
    }
  }
}
