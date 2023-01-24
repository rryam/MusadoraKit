//
//  CreatePlaylist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 23/11/22.
//

import Foundation
import MusicKit

public extension MLibrary {

	/// Creates a playlist in the user’s music library.
	///
	/// - Parameters:
	///   - name: The name of the playlist.
	///   - description: An optional description of the playlist.
	/// - Returns: The newly created playlist.
	static func createPlaylist(with name: String, description: String? = nil) async throws -> Playlist {
		let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description))
		return try await createPlaylist(with: creationRequest)
	}

	/// Creates a playlist in the user’s music library with songs.
	///
	/// - Parameters:
	///   - name: The name of the playlist.
	///   - description: An optional description of the playlist.
	///   - items: Add the songs to the playlist.
	/// - Returns: The newly created playlist.
	static func createPlaylist(with name: String, description: String? = nil, items: Songs) async throws -> Playlist {
		let tracksData: [PlaylistCreationData] = items.map { .init(id: $0.id.rawValue, type: .song)}

		let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description), relationships: .init(tracks: .init(data: tracksData)))
		return try await createPlaylist(with: creationRequest)
	}

	/// Creates a playlist in the user’s music library with song IDs.
	///
	/// - Parameters:
	///   - name: The name of the playlist.
	///   - description: An optional description of the playlist.
	///   - songIds: IDs of Songs
	/// - Returns: The newly created playlist.
	static func createPlaylist(with name: String, description: String? = nil, songIds: [MusicItemID]) async throws -> Playlist {
		let tracksData: [PlaylistCreationData] = songIds.map { .init(id: $0.rawValue, type: .song) }

		let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description), relationships: .init(tracks: .init(data: tracksData)))
		return try await createPlaylist(with: creationRequest)
	}

	static func createPlaylist(with name: String, description: String? = nil, items: Tracks) async throws -> Playlist {
		let tracksData: [PlaylistCreationData] = try items.compactMap {
			let data = try JSONEncoder().encode($0.playParameters)
			let playParameters = try JSONDecoder().decode(MusicPlayParameters.self, from: data)
			let id = playParameters.id.rawValue

			if playParameters.kind == "song" {
				if let isLibrary = playParameters.isLibrary, isLibrary {
					return PlaylistCreationData(id: id, type: .librarySong)
				} else {
					return PlaylistCreationData(id: id, type: .song)
				}
			} else if playParameters.kind == "musicVideo" {
				if let isLibrary = playParameters.isLibrary, isLibrary {
					return PlaylistCreationData(id: id, type: .libraryMusicVideo)
				} else {
					return PlaylistCreationData(id: id, type: .musicVideo)
				}
			} else {
				return nil
			}
		}

		let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description), relationships: .init(tracks: .init(data: tracksData)))
		return try await createPlaylist(with: creationRequest)
	}

	static func createPlaylist(with name: String, description: String? = nil, items: [any PlaylistAddable]) async throws -> Playlist {
		let tracksData: [PlaylistCreationData] = try items.compactMap {
			let data = try JSONEncoder().encode($0.playParameters)
			let playParameters = try JSONDecoder().decode(MusicPlayParameters.self, from: data)
			let id = playParameters.id.rawValue

			if playParameters.kind == "song" {
				if let isLibrary = playParameters.isLibrary, isLibrary {
					return PlaylistCreationData(id: id, type: .librarySong)
				} else {
					return PlaylistCreationData(id: id, type: .song)
				}
			} else if playParameters.kind == "musicVideo" {
				if let isLibrary = playParameters.isLibrary, isLibrary {
					return PlaylistCreationData(id: id, type: .libraryMusicVideo)
				} else {
					return PlaylistCreationData(id: id, type: .musicVideo)
				}
			} else {
				return nil
			}
		}

		let creationRequest = LibraryPlaylistCreationRequest(attributes: .init(name: name, description: description), relationships: .init(tracks: .init(data: tracksData)))
		return try await createPlaylist(with: creationRequest)

	}

	@discardableResult static func add(songIDs: [MusicItemID], to playlistID: MusicItemID) async throws -> Bool {
		let songData = songIDs.map { PlaylistCreationData(id: $0.rawValue, type: .song) }
		let tracks = PlaylistCreationTracks(data: songData)

		let url = URL(string: "https://api.music.apple.com/v1/me/library/playlists/\(playlistID.rawValue)/tracks")

		guard let url = url else { throw URLError(.badURL) }

		let data = try JSONEncoder().encode(tracks)

		let request = MDataPostRequest(url: url, data: data)
		let response = try await request.response()
		return response.urlResponse.statusCode == 201
	}

	@discardableResult static func add(songs: Songs, to playlist: Playlist) async throws -> Bool {
		try await add(songIDs: songs.map(\.id), to: playlist.id)
	}

	static private func createPlaylist(with creationRequest: LibraryPlaylistCreationRequest) async throws -> Playlist {
		let url = URL(string: "https://api.music.apple.com/v1/me/library/playlists")

		guard let url = url else { throw URLError(.badURL) }

		let data = try JSONEncoder().encode(creationRequest)

		let request = MDataPostRequest(url: url, data: data)
		let response = try await request.response()

		let playlists = try JSONDecoder().decode(Playlists.self, from: response.data)

		guard let playlist = playlists.first else {
			throw MusadoraKitError.notFound(for: creationRequest.attributes.name)
		}

		return playlist
	}
}

public protocol PlaylistAddable: MusicItem {

	/// The parameters to use to play the item.
	var playParameters: PlayParameters? { get }
}

extension Song: PlaylistAddable { }

extension Track: PlaylistAddable { }

extension MusicVideo: PlaylistAddable { }

public struct MusicPlayParameters: Codable {
	public var id: MusicItemID
	public var isLibrary: Bool?
	public var kind: String
	public var catalogId: MusicItemID?
	public var globalId: MusicItemID?
}

enum LibraryPlaylistCreationTrackType: String, Codable {
	case song = "songs"
	case musicVideo = "music-videos"
	case libraryMusicVideo = "library-music-videos"
	case librarySong = "library-songs"
}

struct LibraryPlaylistCreationRequest: Codable {
	/// A dictionary that includes strings for the name and description of the new playlist.
	var attributes: PlaylistCreationAttributes

	/// To include tracks for the new playlist.
	var relationships: PlaylistCreationRelationships?
}

struct PlaylistCreationAttributes: Codable {
	/// The name of the playlist.
	var name: String

	/// The description of the playlist.
	var description: String?
}

struct PlaylistCreationRelationships: Codable {
	var tracks: PlaylistCreationTracks
}

struct PlaylistCreationTracks: Codable {
	/// Data of the tracks to add to the created library playlist.
	var data: [PlaylistCreationData]
}

struct PlaylistCreationData: Codable {
	/// The unique identifier for the track.
	/// This ID can be a catalog identifier or a library identifier, depending on the track type.
	var id: String

	/// The type of the track to be added.
	var type: LibraryPlaylistCreationTrackType
}
