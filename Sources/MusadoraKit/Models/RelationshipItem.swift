//
//  RelationshipItem.swift
//  RelationshipItem
//
//  Created by Rudrank Riyam on 04/08/21.
//

import Foundation

/// An enum representing the types of items that can be related to a music item.
public enum RelationshipItem: String {
  case albums
  case artists
  case composers
  case genres
  case library
  case musicVideos = "music-videos"
  case station
}
