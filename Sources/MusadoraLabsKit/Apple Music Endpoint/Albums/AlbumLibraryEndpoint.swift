//
//  AlbumLibraryEndpoint.swift
//  AlbumLibraryEndpoint
//
//  Created by Rudrank Riyam on 20/04/22.
//

import Foundation

// MARK: - Requesting User Library Albums

enum AlbumLibraryEndpoint {
  case all
  case id(id: String)
  case ids(ids: [String])
}

// MARK: - Endpoint

extension AlbumLibraryEndpoint: Endpoint {
  var name: String {
    switch self {
    case .all:
      return "Get All Library Albums"
    case .id:
      return "Get a Library Album"
    case .ids:
      return "Get Multiple Library Albums"
    }
  }

  var description: String {
    switch self {
    case .all:
      return "Fetch all the library albums in alphabetical order."
    case .id:
      return "Fetch a library album by using its identifier."
    case .ids:
      return "Fetch one or more library albums by using their identifiers."
    }
  }

  var previewURL: String {
    switch self {
    case .all:
      return "https://api.music.apple.com/v1/me/library/albums/{id}"
    case .id:
      return "https://api.music.apple.com/v1/me/library/albums?ids={ids}"
    case .ids:
      return "https://api.music.apple.com/v1/me/library/albums"
    }
  }

  var url: URL {
    get async throws {
      switch self {
      case .all:
        return try await MusadoraLabsKit.libraryAlbums()
      case let .id(id):
        return try await MusadoraLabsKit.libraryAlbum(id: id)
      case let .ids(ids):
        return try await MusadoraLabsKit.libraryAlbums(ids: ids)
      }
    }
  }
}

// MARK: - Identifiable

extension AlbumLibraryEndpoint: Hashable, Identifiable {
  public var id: Self { self }
}

// MARK: - CaseIterable

// extension AlbumLibraryEndpoint: CaseIterable {
//    static public var allCases: [AlbumCatalogEndpoint] = [.all, .id(id: ""), .ids(ids: [])]
// }
