//
//  AddRating.swift
//  AddRating
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation

struct AddRating: Codable {
    var type: String = "rating"
    let attributes: Attributes

    struct Attributes: Codable {
        let value: RatingType
    }
}
