//
//  MCatalogSearchType.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// A collection of catalog search types that can be used in search requests.
///
/// This type alias provides a convenient way to work with arrays of `MCatalogSearchType`.
///
/// Example usage:
/// ```swift
/// let searchTypes: MCatalogSearchTypes = [.songs, .albums]
/// let response = try await MCatalog.search(for: "coldplay", types: searchTypes)
/// ```
public typealias MCatalogSearchTypes = [MCatalogSearchType]

/// An enumeration representing the different types of items that can be searched in the Apple Music catalog.
///
/// Use these types to specify which kind of content you want to search for when making catalog search requests.
/// Some search types are only available on newer OS versions.
///
/// Example usage:
/// ```swift
/// // Basic search for songs and albums
/// let types: [MCatalogSearchType] = [.songs, .albums]
/// let results = try await MCatalog.search(for: "taylor swift", types: types)
///
/// // Search including newer content types (iOS 15.4+)
/// if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *) {
///     let types: [MCatalogSearchType] = [.songs, .musicVideos, .curators]
///     let results = try await MCatalog.search(for: "drake", types: types)
/// }
/// ```
public enum MCatalogSearchType {
  /// Search for songs in the catalog.
  case songs

  /// Search for albums in the catalog.
  case albums

  /// Search for playlists in the catalog.
  case playlists

  /// Search for artists in the catalog.
  case artists

  /// Search for stations in the catalog.
  case stations

  /// Search for record labels in the catalog.
  case recordLabels

  /// Search for music videos, curators, and radio shows in the catalog.
  /// Available on iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, and visionOS 1.0 or later.
  @available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
  case musicVideos, curators, radioShows

  /// Returns the corresponding `MusicCatalogSearchable` type for the search type.
  ///
  /// This property is used internally to convert the enum cases to their corresponding
  /// searchable types when making catalog search requests.
  public var type: MusicCatalogSearchable.Type? {
    switch self {
    case .songs:
      return Song.self
    case .albums:
      return Album.self
    case .playlists:
      return Playlist.self
    case .artists:
      return Artist.self
    case .stations:
      return Station.self
    case .recordLabels:
      return RecordLabel.self

    case .musicVideos:
      if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *) {
        return MusicVideo.self
      } else {
        return nil
      }
    case .curators:
      if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *) {
        return Curator.self
      } else {
        return nil
      }
    case .radioShows:
      if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *) {
        return RadioShow.self
      } else {
        return nil
      }
    }
  }
}

public extension MCatalogSearchTypes {
  public static var all: Self {
    var types: Self = [.songs, .albums, .playlists, .artists, .stations, .recordLabels]

    if #available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *) {
      types += [.musicVideos, .curators, .radioShows]
      return types
    } else {
      return types
    }
  }
}
