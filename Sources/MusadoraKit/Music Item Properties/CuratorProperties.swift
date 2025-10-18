//
//  CuratorProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// Additional property/relationship of an artist.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public typealias CuratorProperty = PartialMusicAsyncProperty<Curator>

/// Additional properties/relationships of an artist.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public typealias CuratorProperties = [CuratorProperty]

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public extension CuratorProperties {
  static var all: Self {
    [.playlists]
  }
}
