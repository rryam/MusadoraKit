// 
//  MusicRecentlyAddedRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 30/06/22.
//

import Foundation

/// A protocol for music items that your app can fetch by
/// using a recently added request.
public protocol MusicRecentlyAddedRequestable: MusicItem, MusicPropertyContainer {}

/// A request that your app uses to fetch items the user has recently added.
public struct MusicRecentlyAddedRequest<MusicItemType>
where MusicItemType: MusicRecentlyAddedRequestable, MusicItemType: Decodable {
  /// Creates a request for items the user has recently added.
  public init() {}

  /// A limit for the number of items to return
  /// in the response that contains items the user has recently added.
  public var limit: Int?

  /// An offet for the request.
  public var offset: Int?

  /// A list of properties which the recently added request
  /// will fetch for each music item in the response.
  public var properties: [PartialMusicAsyncProperty<MusicItemType>] = []

  /// Fetches items the user has recently added.
  public func response() async throws -> MusicRecentlyAddedResponse<MusicItemType> {
    var request = MusicHistoryRequest(for: .recentlyAdded)
    request.limit = limit
    request.offset = offset

    let history = try await request.response()
    let items = try filteredItems(from: history)
    let hydratedItems = try await resolvedItems(from: items)
    return MusicRecentlyAddedResponse(items: hydratedItems)
  }

  internal func filteredItems(from history: MusicHistoryResponse) throws -> MusicItemCollection<MusicItemType> {
    MusicItemCollection(try filteredItems(from: Array(history.items)))
  }

  internal func filteredItems(from items: [UserMusicItem]) throws -> [MusicItemType] {
    let mapper = try itemMapper()
    return items.compactMap(mapper)
  }

  private func itemMapper() throws -> (UserMusicItem) -> MusicItemType? {
    switch MusicItemType.self {
    case is Album.Type:
      return album(from:)
    case is Playlist.Type:
      return playlist(from:)
    case is Station.Type:
      return station(from:)
    case is Track.Type:
      return track(from:)
    case is Song.Type:
      return song(from:)
    case is MusicVideo.Type:
      return musicVideo(from:)
    default:
      throw MusadoraKitError.invalidLibraryItemType
    }
  }

  private func album(from item: UserMusicItem) -> MusicItemType? {
    guard case let .album(album) = item else { return nil }
    return album as? MusicItemType
  }

  private func playlist(from item: UserMusicItem) -> MusicItemType? {
    guard case let .playlist(playlist) = item else { return nil }
    return playlist as? MusicItemType
  }

  private func station(from item: UserMusicItem) -> MusicItemType? {
    guard case let .station(station) = item else { return nil }
    return station as? MusicItemType
  }

  private func track(from item: UserMusicItem) -> MusicItemType? {
    guard case let .track(track) = item else { return nil }
    return track as? MusicItemType
  }

  private func song(from item: UserMusicItem) -> MusicItemType? {
    guard case let .track(track) = item, case let .song(song) = track else { return nil }
    return song as? MusicItemType
  }

  private func musicVideo(from item: UserMusicItem) -> MusicItemType? {
    guard case let .track(track) = item, case let .musicVideo(musicVideo) = track else { return nil }
    return musicVideo as? MusicItemType
  }

  private func resolvedItems(from items: MusicItemCollection<MusicItemType>) async throws -> MusicItemCollection<MusicItemType> {
    guard !properties.isEmpty else {
      return items
    }

    var resolvedItems: [MusicItemType] = []
    resolvedItems.reserveCapacity(items.count)

    for item in items {
      resolvedItems.append(try await item.with(properties))
    }

    return MusicItemCollection(resolvedItems)
  }
}

extension Album: MusicRecentlyAddedRequestable {}

extension MusicVideo: MusicRecentlyAddedRequestable {}

extension Playlist: MusicRecentlyAddedRequestable {}

extension Song: MusicRecentlyAddedRequestable {}

extension Station: MusicRecentlyAddedRequestable {}

extension Track: MusicRecentlyAddedRequestable {}

/// A response that contains items the user has recently added to their library.
///
/// This structure provides access to a collection of music items that have been recently
/// added to the user's Apple Music library. The items can be of any type that conforms
/// to the `MusicRecentlyAddedRequestable` protocol.
///
/// Example usage:
/// ```swift
/// let request = MusicRecentlyAddedRequest<Song>()
///
/// do {
///     let response = try await request.response()
///     for song in response.items {
///         print("Recently added song: \(song.title)")
///     }
/// } catch {
///     print("Failed to fetch recently added items: \(error)")
/// }
/// ```
public struct MusicRecentlyAddedResponse<MusicItemType> where MusicItemType: MusicRecentlyAddedRequestable {
  /// A collection of items the user has recently added.
  ///
  /// This property contains the music items that were recently added to the user's library,
  /// ordered by the date they were added (most recent first).
  public let items: MusicItemCollection<MusicItemType>
}

extension MusicRecentlyAddedResponse: Sendable {
}

extension MusicRecentlyAddedResponse: Decodable where MusicItemType: Decodable {
}

extension MusicRecentlyAddedResponse: Encodable where MusicItemType: Encodable {
}
