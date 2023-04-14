//
//  MContinuousTrackData.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

/// Represents data for a continuous track request.
struct MContinuousTrackData: Encodable {

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
struct MContinuousTrackDatum: Encodable {

  /// The ID of the song for the continuous track request.
  let id: MusicItemID

  /// The type of the item being requested.
  let type = "songs"

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

  /// Represents metadata for a continuous track request.
  struct MContinuousTrackMetadata: Encodable {

    /// The container for the continuous track request.
    let container: MContinuousTrackContainer
  }

  /// Represents a container for a continuous track request.
  struct MContinuousTrackContainer: Encodable {

    /// The ID of the album for the continuous track request.
    let id: MusicItemID

    /// The type of the container for the continuous track request.
    let type = "albums"
  }
}
