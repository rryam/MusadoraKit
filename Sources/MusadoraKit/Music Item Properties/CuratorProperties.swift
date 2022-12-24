//
//  CuratorProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

import MusicKit

/// Additional property/relationship of an artist.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
public typealias CuratorProperty = PartialMusicAsyncProperty<Curator>

/// Additional properties/relationships of an artist.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
public typealias CuratorProperties = [CuratorProperty]

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
extension CuratorProperties {
  public static var all: Self {
    [.playlists]
  }
}
