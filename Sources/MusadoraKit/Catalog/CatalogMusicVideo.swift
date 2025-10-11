//
//  CatalogMusicVideo.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

public extension MCatalog {
  /// Fetch a music video from the Apple Music catalog by using its identifier.
  /// - Parameters:
  ///   - id: The unique identifier for the music video.
  ///   - properties: Additional relationships to fetch with the music video.
  /// - Returns: `MusicVideo` matching the given identifier.
  static func musicVideo(id: MusicItemID, fetch properties: MusicVideoProperties) async throws -> MusicVideo {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, equalTo: id)
    request.properties = properties
    let response = try await request.response()

    guard let musicVideo = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }
    return musicVideo
  }

  /// Fetch a music video from the Apple Music catalog by using its identifier with all properties.
  /// - Parameters:
  ///   - id: The unique identifier for the music video.
  /// - Returns: `MusicVideo` matching the given identifier.
  static func musicVideo(id: MusicItemID) async throws -> MusicVideo {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, equalTo: id)
    request.properties = .all
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
  static func musicVideos(ids: [MusicItemID], fetch properties: MusicVideoProperties) async throws -> MusicVideos {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, memberOf: ids)
    request.properties = properties
    let response = try await request.response()
    return try await response.items.collectingAll()
  }

  /// Fetch multiple music videos from the Apple Music catalog by using their identifiers with all properties.
  /// - Parameters:
  ///   - ids: The unique identifiers for the  music videos.
  /// - Returns: `MusicVideos` matching the given identifiers.
  static func musicVideos(ids: [MusicItemID]) async throws -> MusicVideos {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, memberOf: ids)
    request.properties = .all
    let response = try await request.response()
    return try await response.items.collectingAll()
  }

  /// Fetch one or more music videos from Apple Music catalog by using their ISRC value.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the music videos.
  ///   - properties: Additional relationships to fetch with the music videos.
  /// - Returns: `MusicVideos` matching the given ISRC value.
  ///
  /// - Note: One ISRC value may return more than one music video.
  static func musicVideo(isrc: String, fetch properties: MusicVideoProperties) async throws -> MusicVideos
  {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.isrc, equalTo: isrc)
    request.properties = properties
    let response = try await request.response()
    return try await response.items.collectingAll()
  }

  /// Fetch one or more music videos from Apple Music catalog by using their ISRC value with all properties.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the music videos.
  /// - Returns: `MusicVideos` matching the given ISRC value.
  ///
  /// - Note: One ISRC value may return more than one music video.
  static func musicVideo(isrc: String) async throws -> MusicVideos {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.isrc, equalTo: isrc)
    request.properties = .all
    let response = try await request.response()
    return try await response.items.collectingAll()
  }

  /// Fetch multiple music videos from Apple Music catalog by using their ISRC values.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the music videos.
  ///   - properties: Additional relationships to fetch with the music videos.
  /// - Returns: `MusicVideos` matching the given ISRC values.
  ///
  /// - Note: One ISRC value may return more than one music video.
  static func musicVideos(isrc: [String], fetch properties: MusicVideoProperties) async throws -> MusicVideos
  {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.isrc, memberOf: isrc)
    request.properties = properties
    let response = try await request.response()
    return try await response.items.collectingAll()
  }

  /// Fetch multiple music videos from Apple Music catalog by using their ISRC values with all properties.
  ///
  /// - Parameters:
  ///   - isrc: The ISRC values for the music videos.
  /// - Returns: `MusicVideos` matching the given ISRC values.
  ///
  /// - Note: One ISRC value may return more than one music video.
  static func musicVideos(isrc: [String]) async throws -> MusicVideos {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.isrc, memberOf: isrc)
    request.properties = .all
    let response = try await request.response()
    return try await response.items.collectingAll()
  }
}
