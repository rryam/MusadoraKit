//
//  CuratorProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

import MusicKit

/// Additional property/relationship of an artist.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public typealias CuratorProperty = PartialMusicAsyncProperty<Curator>

/// Additional properties/relationships of an artist.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
public typealias CuratorProperties = [CuratorProperty]

@available(iOS 15.4, macOS 12.3, tvOS 15.4, *)
@available(watchOS, unavailable)
extension CuratorProperties {
  public static var all: Self {
    [.playlists]
  }
}
