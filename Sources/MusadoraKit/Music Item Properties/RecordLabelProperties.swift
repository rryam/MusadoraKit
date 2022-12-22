//
//  RecordLabelProperties.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 22/12/22.
//

import MusicKit

/// Additional property/relationship of a record label.
public typealias RecordLabelProperty = PartialMusicAsyncProperty<RecordLabel>

/// Additional properties/relationships of a record label.
public typealias RecordLabelProperties = [RecordLabelProperty]

#if compiler(>=5.7)
extension RecordLabelProperties {
  public static var all: Self {
    [.latestReleases, .topReleases]
  }
}
#endif
