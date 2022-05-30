//
//  AlbumCatalogEndpoint.swift
//  AlbumCatalogEndpoint
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

// MARK: - Requesting Catalog Albums

public enum AlbumCatalogEndpoint {
  case id(id: String)
  case ids(ids: [String])
  case upcs(upcs: [String])
}

// MARK: - Endpoint

extension AlbumCatalogEndpoint: Endpoint {
  public var name: String {
    switch self {
    case .id:
      return "Get a Catalog Album"
    case .ids:
      return "Get Multiple Catalog Albums"
    case .upcs:
      return "Get Multiple Catalog Albums by UPC"
    }
  }

  public var description: String {
    switch self {
    case .id:
      return "Fetch an album by using its identifier."
    case .ids:
      return "Fetch one or more albums by using their identifiers."
    case .upcs:
      return "Fetch one or more albums by using their UPC values."
    }
  }

  var previewURL: String {
    switch self {
    case .id:
      return "https://api.music.apple.com/v1/catalog/{storefront}/albums/{id}"
    case .ids:
      return "https://api.music.apple.com/v1/catalog/{storefront}/albums?ids={ids}"
    case .upcs:
      return "https://api.music.apple.com/v1/catalog/{storefront}/albums?filter[upc]={upcs}"
    }
  }

  var url: URL {
    get async throws {
      switch self {
      case let .id(id):
        return try await MusadoraLabsKit.catalogAlbum(id: id)
      case let .ids(ids):
        return try await MusadoraLabsKit.catalogAlbums(ids: ids)
      case let .upcs(upcs):
        return try await MusadoraLabsKit.catalogAlbums(upcs: upcs)
      }
    }
  }
}

// MARK: - Identifiable

extension AlbumCatalogEndpoint: Hashable, Identifiable {
  public var id: Self { self }
}

// MARK: - CaseIterable

extension AlbumCatalogEndpoint: CaseIterable {
  public static var allCases: [AlbumCatalogEndpoint] = [.id(id: ""), .ids(ids: []), .upcs(upcs: [])]
}
