// 
//  MusicRecentlyAddedRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 30/06/22.
//

import Foundation

/// A protocol for music items that your app can fetch by
/// using a recently added request.
public protocol MusicRecentlyAddedRequestable: MusicItem {
}

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

  // Fetches items the user has recently added.
  //    public func response() async throws -> MusicRecentlyAddedResponse<MusicItemType> {
  //        return MusicRecentlyAddedResponse(items: .init(arrayLiteral: []))
  //    }
}

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
