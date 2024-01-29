//
//  MContinuousTrackData.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

/// Represents data for a continuous track request.
struct MContinuousTrackData: Codable {

  /// The data for the continuous track request.
  let data: [MContinuousTrackDatum]

  /// Initializes a `MContinuousTrackData` object with the given song and album IDs.
  ///
  /// - Parameters:
  ///   - songID: The ID of the song for which the continuous track request is being made.
  ///   - albumID: The ID of the album to which the song belongs.
  init(songID: MusicItemID, albumID: MusicItemID) {
    self.data = [MContinuousTrackDatum(songID: songID, albumID: albumID)]
  }
}

/// Represents a datum for a continuous track request.
struct MContinuousTrackDatum: Codable {

  /// The ID of the song for the continuous track request.
  let id: MusicItemID

  /// The type of the item being requested.
  var type = "songs"

  /// The metadata for the continuous track request.
  let meta: MContinuousTrackMetadata

  /// Initializes a `MContinuousTrackDatum` object with the given song and album IDs.
  ///
  /// - Parameters:
  ///   - songID: The ID of the song for which the continuous track request is being made.
  ///   - albumID: The ID of the album to which the song belongs.
  init(songID: MusicItemID, albumID: MusicItemID) {
    id = songID
    meta = MContinuousTrackMetadata(container: MContinuousTrackContainer(id: albumID))
  }
}

/// Represents metadata for a continuous track request.
struct MContinuousTrackMetadata: Codable {

  /// The container for the continuous track request.
  let container: MContinuousTrackContainer
}

/// Represents a container for a continuous track request.
struct MContinuousTrackContainer: Codable {

  /// The ID of the album for the continuous track request.
  let id: MusicItemID

  /// The type of the container for the continuous track request.
  var type = "albums"
}

extension MContinuousTrackData: Equatable {
  static func ==(lhs: MContinuousTrackData, rhs: MContinuousTrackData) -> Bool {
    return lhs.data == rhs.data
  }
}

extension MContinuousTrackDatum: Equatable {
  static func ==(lhs: MContinuousTrackDatum, rhs: MContinuousTrackDatum) -> Bool {
    return lhs.id == rhs.id && lhs.type == rhs.type && lhs.meta == rhs.meta
  }
}

extension MContinuousTrackMetadata: Equatable {
  static func ==(lhs: MContinuousTrackMetadata, rhs: MContinuousTrackMetadata) -> Bool {
    return lhs.container == rhs.container
  }
}

extension MContinuousTrackContainer: Equatable {
  static func ==(lhs: MContinuousTrackContainer, rhs: MContinuousTrackContainer) -> Bool {
    return lhs.id == rhs.id && lhs.type == rhs.type
  }
}

