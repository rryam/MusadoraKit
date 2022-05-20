//
//  RatingRequest.swift
//  RatingRequest
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

struct RatingRequest: Encodable {
  let type: String = "ratings"
  let attributes: Attributes

  struct Attributes: Encodable {
    let value: RatingsType
  }
}
