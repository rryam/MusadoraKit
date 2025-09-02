//
//  MSummaryResponse.swift
//  MusadoraKit
//
//  Created by Codex on 02/09/25.
//

import Foundation

/// An object that contains results for a music summaries (Replay) request.
///
/// Surfaces the three primary views supported by the endpoint
/// (`top-artists`, `top-albums`, `top-songs`) as MusicKit collections.
public struct MSummaryResponse {
  /// Top artists for the latest eligible year (ordered as returned by the API).
  public let topArtists: Artists

  /// Top albums for the latest eligible year (ordered as returned by the API).
  public let topAlbums: Albums

  /// Top songs for the latest eligible year (ordered as returned by the API).
  public let topSongs: Songs

  /// The year of the summary.
  public let year: Int?
}

extension MSummaryResponse {
  /// Parses the raw data using the documented Apple schema.
  static func parse(from data: Data, using decoder: JSONDecoder) throws -> MSummaryResponse {
    let topLevel = try decoder.decode(SummariesResponsePayload.self, from: data)
    // The endpoint returns a collection; pick the first summaries object.
    guard let summaries = topLevel.data.first else {
      return MSummaryResponse(topArtists: MusicItemCollection([]),
                              topAlbums: MusicItemCollection([]),
                              topSongs: MusicItemCollection([]),
                              year: nil)
    }

    // Flatten period summaries relationships into plain MusicKit collections.
    let artists: [Artist] = (summaries.views?.topArtists?.data ?? [])
      .compactMap { summary in summary.relationships?.artist?.data.first }

    let albums: [Album] = (summaries.views?.topAlbums?.data ?? [])
      .compactMap { summary in summary.relationships?.album?.data.first }

    let songs: [Song] = (summaries.views?.topSongs?.data ?? [])
      .compactMap { summary in summary.relationships?.song?.data.first }

    return MSummaryResponse(
      topArtists: MusicItemCollection(artists),
      topAlbums: MusicItemCollection(albums),
      topSongs: MusicItemCollection(songs),
      year: summaries.attributes?.year
    )
  }
}

extension MSummaryResponse: Equatable, Hashable {}

extension MSummaryResponse: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    "MSummaryResponse(year: \(year.map(String.init) ?? "nil"), artists: \(topArtists.count), albums: \(topAlbums.count), songs: \(topSongs.count))"
  }

  public var debugDescription: String {
    "MSummaryResponse(\n\(topArtists.debugDescription),\n\(topAlbums.debugDescription),\n\(topSongs.debugDescription)\n)"
  }
}

// MARK: - Codable models for the documented Music Summaries schema

private struct SummariesResponsePayload: Decodable {
  let data: [SummariesPayload]
}

private struct SummariesPayload: Decodable {
  let id: String
  let type: String
  let href: String?
  let attributes: SummariesAttributes?
  let views: SummariesViews?
}

private struct SummariesAttributes: Decodable {
  let period: String
  let year: Int
}

private struct SummariesViews: Decodable {
  let topAlbums: TopAlbumsView?
  let topArtists: TopArtistsView?
  let topSongs: TopSongsView?

  private enum CodingKeys: String, CodingKey {
    case topAlbums = "top-albums"
    case topArtists = "top-artists"
    case topSongs = "top-songs"
  }
}

// MARK: Views

private struct TopAlbumsView: Decodable { let data: [AlbumPeriodSummary] }
private struct TopArtistsView: Decodable { let data: [ArtistPeriodSummary] }
private struct TopSongsView: Decodable { let data: [SongPeriodSummary] }

// MARK: Period summary wrappers

private struct AlbumPeriodSummary: Decodable { let relationships: AlbumPeriodRelationships? }
private struct ArtistPeriodSummary: Decodable { let relationships: ArtistPeriodRelationships? }
private struct SongPeriodSummary: Decodable { let relationships: SongPeriodRelationships? }

// MARK: Relationships

private struct AlbumPeriodRelationships: Decodable { let album: AlbumRelationship? }
private struct ArtistPeriodRelationships: Decodable { let artist: ArtistRelationship? }
private struct SongPeriodRelationships: Decodable { let song: SongRelationship? }

// Minimal identifier object returned in relationship linkages when attributes are omitted
private struct MinimalResource: Decodable { let id: MusicItemID }

private struct AlbumRelationship: Decodable {
  let data: [Album]

  private enum CodingKeys: String, CodingKey { case data }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let albums = try? container.decode([Album].self, forKey: .data) {
      self.data = albums
    } else if let refs = try? container.decode([MinimalResource].self, forKey: .data) {
      self.data = refs.map { Album(id: $0.id) }
    } else {
      self.data = []
    }
  }
}

private struct ArtistRelationship: Decodable {
  let data: [Artist]

  private enum CodingKeys: String, CodingKey { case data }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let artists = try? container.decode([Artist].self, forKey: .data) {
      self.data = artists
    } else if let refs = try? container.decode([MinimalResource].self, forKey: .data) {
      self.data = refs.map { Artist(id: $0.id) }
    } else {
      self.data = []
    }
  }
}

private struct SongRelationship: Decodable {
  let data: [Song]

  private enum CodingKeys: String, CodingKey { case data }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let songs = try? container.decode([Song].self, forKey: .data) {
      self.data = songs
    } else if let refs = try? container.decode([MinimalResource].self, forKey: .data) {
      self.data = refs.map { Song(id: $0.id) }
    } else {
      self.data = []
    }
  }
}
