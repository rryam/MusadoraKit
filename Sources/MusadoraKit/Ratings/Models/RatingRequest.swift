//
//  RatingRequest.swift
//  RatingRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

struct RatingRequest: Encodable {
  private let type: String = "ratings"
  private let attributes: Attributes

  private struct Attributes: Encodable {
    let value: RatingType
  }

  init(value: RatingType) {
    attributes = Attributes(value: value)
  }
}
