//
//  RatingRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/05/22.
//

/// A request to create or update a rating for a content item in the Apple Music Catalog.
struct RatingRequest: Encodable {

  /// The type of the request.
  private let type: String = "ratings"

  /// The attributes of the request.
  private let attributes: Attributes

  /// The attributes of the rating.
  private struct Attributes: Encodable {
    /// The value of the rating.
    let value: RatingType
  }

  /// Creates a new rating request with the specified rating value.
  ///
  /// - Parameter value: The value of the rating.
  init(value: RatingType) {
    attributes = Attributes(value: value)
  }
}
