//
//  MusicRecommendationItem.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

/// An object that represents recommended resources for a user calculated using their selected preferences.
public struct MusicRecommendationItem: Codable, MusicItem, Identifiable {
  /// The unique identifier for the recommendation.
  public let id: MusicItemID

  /// The localized title for the recommendation.
  public let title: String?

  /// The next date in UTC format for updating the recommendation.
  public let nextRefreshDate: Date?

  /// A collection of recommended albums.
  public var albums: Albums {
    MusicItemCollection(items.compactMap { item in
      guard case let .album(album) = item else { return nil }
      return album
    })
  }

  /// A collection of recommended playlists.
  public var playlists: Playlists {
    MusicItemCollection(items.compactMap { item in
      guard case let .playlist(playlist) = item else { return nil }
      return playlist
    })
  }

  /// A collection of recommended stations.
  public var stations: Stations {
    MusicItemCollection(items.compactMap { item in
      guard case let .station(station) = item else { return nil }
      return station
    })
  }

  /// The contents associated with the content recommendation type.
  /// It is a collection of `UserMusicItem` that are a mixture of albums, playlists and stations.
  public let items: UserMusicItems
}

extension MusicRecommendationItem {
  enum CodingKeys: String, CodingKey {
    case id, attributes, relationships
  }

  enum RelationshipKey: String, CodingKey {
    case contents
  }

  enum AttributesKey: String, CodingKey {
    case title
    case nextRefreshDate = "nextUpdateDate"
  }

  enum TitleKey: String, CodingKey {
    case stringForDisplay
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(MusicItemID.self, forKey: .id)

    let relationshipContainer = try container.nestedContainer(keyedBy: RelationshipKey.self, forKey: .relationships)
    items = try relationshipContainer.decode(UserMusicItems.self, forKey: .contents)

    let attributesContainer = try container.nestedContainer(keyedBy: AttributesKey.self, forKey: .attributes)
    nextRefreshDate = try attributesContainer.decode(Date.self, forKey: .nextRefreshDate)

    let titleContainer = try attributesContainer.nestedContainer(keyedBy: TitleKey.self, forKey: .title)
    title = try titleContainer.decode(String.self, forKey: .stringForDisplay)
  }
}

public extension MusicRecommendationItem {
  func encode(to _: Encoder) throws {}
}

extension MusicRecommendationItem: Equatable, Hashable {}
