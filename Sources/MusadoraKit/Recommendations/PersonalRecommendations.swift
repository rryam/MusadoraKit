//
//  PersonalRecommendations.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 25/12/22.
//



#if compiler(>=5.7)
/// A collection of personal recommendations.
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public typealias PersonalRecommendations = MusicItemCollection<MusicPersonalRecommendation>
#endif
