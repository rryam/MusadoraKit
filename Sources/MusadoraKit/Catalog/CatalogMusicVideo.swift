//
//  CatalogMusicVideo.swift
//  CatalogMusicVideo
//
//  Created by Rudrank Riyam on 08/09/21.
//

import MusicKit

/// A collection of music videos.
public typealias MusicVideos = MusicItemCollection<MusicVideo>

public extension MusadoraKit {
  /// Fetch a music video from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the music video.
  ///   - properties: Additional relationships to fetch with the music video.
  /// - Returns: `MusicVideo` matching the given identifier.
  static func catalogMusicVideo(id: MusicItemID,
                                with properties: [PartialMusicAsyncProperty<MusicVideo>] = []) async throws -> MusicVideo
  {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let musicVideo = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return musicVideo
  }

  /// Fetch multiple music videos from the Apple Music catalog by using their identifiers.
  /// - Parameters:
  ///   - ids: The unique identifiers for the  music videos.
  ///   - properties: Additional relationships to fetch with the  music videos.
  /// - Returns: `MusicVideos` matching the given identifiers.
  static func catalogMusicVideos(ids: [MusicItemID],
                                 with properties: [PartialMusicAsyncProperty<MusicVideo>] = []) async throws -> MusicVideos
  {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch one or more music videos from Apple Music catalog by using their ISRC value.
  ///
  /// Note that one ISRC value may return more than one music video.
  /// - Parameters:
  ///   - isrc: The ISRC values for the music videos.
  ///   - properties: Additional relationships to fetch with the music videos.
  /// - Returns: `MusicVideos` matching the given ISRC value.
  static func catalogMusicVideo(isrc: String,
                                with properties: [PartialMusicAsyncProperty<MusicVideo>] = []) async throws -> MusicVideos
  {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.isrc, equalTo: isrc)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }

  /// Fetch multiple music videos from Apple Music catalog by using their ISRC values.
  ///
  /// Note that one ISRC value may return more than one music video.
  /// - Parameters:
  ///   - isrc: The ISRC values for the music videos.
  ///   - properties: Additional relationships to fetch with the music videos.
  /// - Returns: `MusicVideos` matching the given ISRC values.
  static func catalogMusicVideos(isrc: [String],
                                 with properties: [PartialMusicAsyncProperty<MusicVideo>] = []) async throws -> MusicVideos
  {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.isrc, memberOf: isrc)
    request.properties = properties
    let response = try await request.response()
    return response.items
  }
}
