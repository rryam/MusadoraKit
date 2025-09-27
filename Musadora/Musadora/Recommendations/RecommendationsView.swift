//
//  RecommendationsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 13/03/23.
//

import SwiftUI
import MusadoraKit

struct RecommendationsView: View {
  @State private var recommendations: MRecommendations = []
  @State private var hundredBestAlbums: [HundredBestAlbum] = []

#if os(iOS)
  private let columns = [GridItem(), GridItem()]
#else
  private let columns = [GridItem(.adaptive(minimum: 250))]
#endif

#if os(iOS)
  private let size: Int = 250
#else
  private let size: CGFloat = 250
#endif

  var body: some View {
    NavigationListStack("100 Best Albums") {
      LazyVGrid(columns: columns) {
        ForEach(hundredBestAlbums) { album in
          NavigationLink(destination: { HundredAlbumView(album: album) }, label: {
            VStack(alignment: .leading, spacing: 0) {
              AsyncImage(url: album.artwork.url(width: size, height: size), content: { image in
                image
                  .resizable()
                  .scaledToFit()
                  .cornerRadius(16)
              }, placeholder: {
                Color(cgColor: album.artwork.backgroundColor ?? .init(gray: 1.0, alpha: 1.0))
              })

              Text(album.position + ": " + album.title)
                .font(.headline)
                .padding(.top)
                .lineLimit(1)

              Text(album.artistName)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
            }
            .padding(8)
            .contentShape(RoundedRectangle(cornerRadius: 24))
            .hoverEffect()
          })
          .buttonStyle(.plain)
        }
      }
      .padding(.horizontal)
    }
    .task {
      do {
        // User recommendations(userToken:) to debug in simulator
        hundredBestAlbums = try await MRecommendation.allHundredBestAlbums()
        //   recommendations = try await MRecommendation.default()
      } catch {
        print(error)
      }
    }
  }
}

#Preview("RecommendationsView") {
  RecommendationsView()
}

struct HundredAlbumView: View {
  var album: HundredBestAlbum

  @State private var detailedAlbum: Album?

  var body: some View {
    ScrollView {
      AsyncImage(url: detailedAlbum?.artwork?.url(width: 1024, height: 1024), content: { image in
        image
          .resizable()
          .scaledToFit()
          .cornerRadius(16)
      }, placeholder: {
        Color(cgColor: detailedAlbum?.artwork?.backgroundColor ?? .init(gray: 1.0, alpha: 1.0))
      })
      .padding()

      if let detailedAlbum {
        Text(detailedAlbum.artistName)
          .font(.title2)
          .bold()
          .padding(.bottom)

        Divider()

        ForEach(detailedAlbum.tracks ?? []) { track in
          Button(action: {
            Task {
              APlayer.shared.queue = .init(for: detailedAlbum.tracks ?? [], startingAt: track)
              try? await APlayer.shared.play()
            }
          }, label: {
            VStack {
              HStack {
                Text(track.title)

                Spacer()
              }

              Divider()
            }
          })
          .buttonStyle(.plain)
          .padding(.vertical, 4)
          .padding(.horizontal)
        }
      }
    }
    .navigationTitle(album.title)
    .task {
      detailedAlbum = try? await MCatalog.album(id: album.id, fetch: .tracks)
    }
  }
}
