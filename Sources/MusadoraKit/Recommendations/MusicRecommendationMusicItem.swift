//
//  MusicRecommendationMusicItem.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/08/22.
//

/// A protocol for music items that your app can fetch by
/// using a recommendations request.
public protocol MusicRecommendationMusicItem: MusicItem {
}

extension Playlist: MusicRecommendationMusicItem {
}

extension Station: MusicRecommendationMusicItem {
}

extension Album: MusicRecommendationMusicItem {
}
