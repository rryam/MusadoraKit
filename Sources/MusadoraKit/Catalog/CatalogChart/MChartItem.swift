//
//  MChartItem.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/04/22.
//



/// A protocol for music items that your app can fetch by
/// using a catalog chart request.
public protocol MChartItem {}

extension MChartItem {
  static var objectIdentifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
}

extension Song: MChartItem {}

extension Playlist: MChartItem {}

extension MusicVideo: MChartItem {}

extension Album: MChartItem {}
