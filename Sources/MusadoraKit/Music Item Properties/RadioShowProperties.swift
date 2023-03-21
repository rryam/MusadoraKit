//
//  RadioShowProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// Additional property/relationship of a radio show.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
public typealias RadioShowProperty = PartialMusicAsyncProperty<RadioShow>

/// Additional properties/relationships of a radio show.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
public typealias RadioShowProperties = [RadioShowProperty]

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, *)
extension RadioShowProperties {
  public static var all: Self {
    [.playlists]
  }
}
