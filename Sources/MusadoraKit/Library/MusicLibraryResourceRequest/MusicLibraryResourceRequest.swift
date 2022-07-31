//
//  MusicLibraryResourceRequest.swift
//  MusicLibraryResourceRequest
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation
import MusicKit

/// A request that your app uses to fetch items from the user's library
/// using a filter.
public struct MusicLibraryResourceRequest<MusicItemType: MusicItem & Codable> {
  /// A limit for the number of items to return
  /// in the catalog resource response.
  public var limit: Int?
  
  /// Creates a request to fetch all the items in alphabetical order.
  public init() {
    setType()
  }
  
  /// Creates a request to fetch items using a filter that matches
  /// a specific value.
  public init<Value>(matching _: KeyPath<MusicItemType.FilterLibraryType, Value>, equalTo value: Value) where MusicItemType: FilterableLibraryItem {
    setType()
    
    if let id = value as? MusicItemID {
      ids = [id.rawValue]
    }
  }
  
  /// Creates a request to fetch items using a filter that matches
  /// any value from an array of possible values.
  public init<Value>(matching _: KeyPath<MusicItemType.FilterLibraryType, Value>, memberOf values: [Value]) where MusicItemType: FilterableLibraryItem {
    setType()
    
    if let ids = values as? [MusicItemID] {
      self.ids = ids.map { $0.rawValue }
    }
  }
  
  /// Fetches items from the user's library that match a specific filter.
  public func response() async throws -> MusicLibraryResourceResponse<MusicItemType> {
    let url = try libraryEndpointURL
    let request = MusicDataRequest(urlRequest: .init(url: url))
    let response = try await request.response()
    let items = try JSONDecoder().decode(MusicItemCollection<MusicItemType>.self, from: response.data)
    return MusicLibraryResourceResponse(items: items)
  }
  
  private var type: LibraryMusicItemType?
  private var ids: [String]?
}

extension MusicLibraryResourceRequest {
  private mutating func setType() {
    switch MusicItemType.self {
      case is Song.Type: type = .songs
      case is Album.Type: type = .albums
      case is Artist.Type: type = .artists
      case is MusicVideo.Type: type = .musicVideos
      case is Playlist.Type: type = .playlists
      default: type = nil
    }
  }
  
  internal var libraryEndpointURL: URL {
    get throws {
      guard let type = type else { throw URLError(.badURL) }
      
      var components = AppleMusicURLComponents()
      var queryItems: [URLQueryItem]?
      components.path = "me/library/\(type.rawValue)"
      
      if let ids = ids {
        queryItems = [URLQueryItem(name: "ids", value: ids.joined(separator: ","))]
      } else if let limit = limit {
        queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]
      }
      
      components.queryItems = queryItems
      
      guard let url = components.url else {
        throw URLError(.badURL)
      }
      
      return url
    }
  }
}
