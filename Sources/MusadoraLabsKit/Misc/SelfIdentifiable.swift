//
//  SelfIdentifiable.swift
//  SelfIdentifiable
//
//  Created by Rudrank Riyam on 26/07/22.
//

import Foundation

public protocol SelfIdentifiable: Hashable, Identifiable, Codable {}

extension SelfIdentifiable {
    public var id: Self {
        self
    }
}
