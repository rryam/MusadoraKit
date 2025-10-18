//
//  RecordLabelProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

/// Additional property/relationship of a record label.
public typealias RecordLabelProperty = PartialMusicAsyncProperty<RecordLabel>

/// Additional properties/relationships of a record label.
public typealias RecordLabelProperties = [RecordLabelProperty]

public extension RecordLabelProperties {
  static var all: Self {
    [.latestReleases, .topReleases]
  }
}
