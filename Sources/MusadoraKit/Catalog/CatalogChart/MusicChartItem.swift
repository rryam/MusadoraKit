//
//  MusicChartItem.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//

/// A protocol for music items that your app can fetch by
/// using a catalog chart request.
public protocol MusicChartItem {}

extension MusicChartItem {
  static var objectIdentifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
}

extension Song: MusicChartItem {}

extension Playlist: MusicChartItem {}

extension MusicVideo: MusicChartItem {}

extension Album: MusicChartItem {}
