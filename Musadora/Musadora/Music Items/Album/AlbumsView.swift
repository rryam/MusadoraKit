//
//  AlbumsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 15/03/23.
//

import SwiftUI
import MusadoraKit

struct AlbumsView: View {
  private var albums: Albums

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
                AlbumGridCard(album: album)
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
              AlbumGridCard(album: album)
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
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if let artwork = album.artwork {
        ArtworkImage(artwork, width: 150, height: 150)
          .cornerRadius(12)
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
      Task {
        do {
          try await APlayer.shared.play(album: album)
        } catch {
          print(error)
        }
      }
    }
  }
}
