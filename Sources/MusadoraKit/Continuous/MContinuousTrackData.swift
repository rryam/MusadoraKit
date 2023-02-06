//
//  MContinuousTrackData.swift
//  MusadoraKit+
//
//  Created by Rudrank Riyam on 25/01/23.
//

import Foundation
import MusicKit

struct MContinuousTrackData: Encodable {
	let data: [MContinuousTrackDatum]

	public init(songID: MusicItemID, albumID: MusicItemID) {
		self.data = [MContinuousTrackDatum(songID: songID, albumID: albumID)]
	}
}

struct MContinuousTrackDatum: Encodable {
	let type = "songs"
	let id: MusicItemID
	let meta: MContinuousTrackMetadata

	init(songID: MusicItemID, albumID: MusicItemID) {
		id = songID
		meta = MContinuousTrackMetadata(container: MContinuousTrackContainer(id: albumID))
	}

	struct MContinuousTrackMetadata: Encodable {
		let container: MContinuousTrackContainer
	}

	struct MContinuousTrackContainer: Encodable {
		let id: MusicItemID
		let type = "albums"
	}
}
