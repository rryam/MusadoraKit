//
//  MusicCatalogChart.swift
//  MusicCatalogChart
//
//  Created by Rudrank Riyam on 23/04/22.
//

import MusicKit

/// A protocol for music items that your app can fetch by
/// using a catalog chart request.
public protocol MusadoraCatalogChart {}

extension MusadoraCatalogChart {
  static var objectIdentifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
}

extension Song: MusadoraCatalogChart {}

extension Playlist: MusadoraCatalogChart {}

extension MusicVideo: MusadoraCatalogChart {}

extension Album: MusadoraCatalogChart {}
