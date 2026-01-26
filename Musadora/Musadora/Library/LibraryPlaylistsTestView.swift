//
//  LibraryPlaylistsTestView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 11/14/25.
//

import SwiftUI
import MusadoraKit

struct LibraryPlaylistsTestView: View {
  @State private var playlists: [LibraryPlaylist] = []
  @State private var isLoading = false
  @State private var errorMessage: String?
  @State private var limit: Int = 300

  var body: some View {
    VStack(spacing: 20) {
      Text("Library Playlists Test")
        .font(.title)

      HStack {
        Text("Limit:")
        TextField("Limit", value: $limit, format: .number)
          .textFieldStyle(.roundedBorder)
          .frame(width: 100)

        Button("Fetch Playlists") {
          Task {
            await fetchPlaylists()
          }
        }
        .buttonStyle(.borderedProminent)
      }

      if isLoading {
        ProgressView("Loading...")
      }

      if let errorMessage {
        Text("Error: \(errorMessage)")
          .foregroundStyle(.red)
      }

      if !playlists.isEmpty {
        List {
          Section("Results (\(playlists.count) playlists)") {
            ForEach(Array(playlists.enumerated()), id: \.offset) { index, playlist in
              VStack(alignment: .leading, spacing: 4) {
                Text("[\(index + 1)] \(playlist.attributes.name)")
                  .font(.headline)

                if let description = playlist.attributes.description?.standard {
                  Text("Description: \(description)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }

                HStack {
                  Label("Can Edit: \(playlist.attributes.canEdit ? "Yes" : "No")", systemImage: "pencil")
                  Label("Public: \(playlist.attributes.isPublic ? "Yes" : "No")", systemImage: "globe")
                  Label("Catalog: \(playlist.attributes.hasCatalog ? "Yes" : "No")", systemImage: "music.note.list")
                }
                .font(.caption2)
                .foregroundStyle(.secondary)

                if let dateAdded = playlist.attributes.dateAdded {
                  Text("Date Added: \(dateAdded)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }

                if let trackTypes = playlist.attributes.trackTypes, !trackTypes.isEmpty {
                  Text("Track Types: \(trackTypes.joined(separator: ", "))")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }

                if let globalID = playlist.globalID {
                  Text("Global ID: \(globalID)")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                }
              }
              .padding(.vertical, 4)
            }
          }
        }
      }
    }
    .padding()
  }

  private func fetchPlaylists() async {
    isLoading = true
    errorMessage = nil
    playlists = []

    do {
      let fetchedPlaylists = try await MLibrary.playlists(limit: limit)
      playlists = Array(fetchedPlaylists)
      print("Successfully fetched \(playlists.count) playlists with limit \(limit)")
    } catch {
      errorMessage = error.localizedDescription
      ErrorPresenter.shared.present(message: "Error fetching playlists: \(error.localizedDescription)")
    }

    isLoading = false
  }
}

#Preview {
  LibraryPlaylistsTestView()
}
