//
//  RatingsType.swift
//  RatingsType
//
//  Created by Rudrank Riyam on 20/05/22.
//

/// Represents the type of a rating for a content item in the Apple Music Catalog.
public enum RatingType: Int, Codable {

  /// A positive rating.
  case like = 1

  /// A negative rating.
  case dislike = -1
}
