//
//  MusicRecommendationItem.swift
//  MusicRecommendationItem
//
//  Created by Rudrank Riyam on 25/08/22.
//

import Foundation
import MusicKit

/// A protocol for music items that your app can fetch by
/// using a recommendations request.
public protocol MusicRecommendationItem : MusicItem {
}

extension Playlist : MusicRecommendationItem {
}

extension Station : MusicRecommendationItem {
}

extension Album : MusicRecommendationItem {
}
