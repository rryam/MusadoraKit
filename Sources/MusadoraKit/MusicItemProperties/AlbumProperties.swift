//
//  AlbumProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// Additional property/relationship of an album.
public typealias AlbumProperty = PartialMusicAsyncProperty<Album>

/// Additional properties/relationships of an album.
public typealias AlbumProperties = [AlbumProperty]

public extension AlbumProperties {
  /// All the album properties like artist URL, genres, artists, appears on,
  /// other versions, record labels, related albums, related videos, and tracks.
  /// For iOS 16+, adds the audio variants property.
  static var all: Self {
    var properties: Self = [.artistURL, .genres, .artists, .appearsOn, .otherVersions, .recordLabels, .relatedAlbums, .relatedVideos, .tracks]

    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
      properties += [.audioVariants]
      return properties
    } else {
      return properties
    }
  }
}
