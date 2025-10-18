//
//  MusicLibraryResourcesType.swift
//
//
//  Created by Rudrank Riyam on 23/04/22.
//

/// A collection of music catalog resources types.
typealias MusicLibraryResourcesTypes = MusicItemCollection<MusicLibraryResourcesType>

/// A generic music item to represent each of the library music items.
public enum MusicLibraryResourcesType {
  case album(Album)
  case song(Song)
  case playlist(Playlist)
  case artist(Artist)
  case musicVideo(MusicVideo)

  public enum Key: String, Codable {
    case songs = "library-songs"
    case albums = "library-albums"
    case playlists = "library-playlists"
    case artists = "library-artists"
    case musicVideos = "library-music-videos"

    public var type: String {
      "ids[\(rawValue)]".removingPercentEncoding ?? "ids[\(rawValue)]"
    }
  }
}

extension MusicLibraryResourcesType: MusicItem {
  public var id: MusicItemID {
    let id: MusicItemID

    switch self {
    case let .song(song): id = song.id
    case let .playlist(playlist): id = playlist.id
    case let .artist(artist): id = artist.id
    case let .album(album): id = album.id
    case let .musicVideo(musicVideo): id = musicVideo.id
    }

    return id
  }
}

extension MusicLibraryResourcesType: Decodable {
  enum CodingKeys: CodingKey {
    case type
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let type = try values.decode(MusicLibraryResourcesType.Key.self, forKey: .type)

    switch type {
    case .songs:
      let song = try Song(from: decoder)
      self = .song(song)
    case .playlists:
      let playlist = try Playlist(from: decoder)
      self = .playlist(playlist)
    case .musicVideos:
      let musicVideo = try MusicVideo(from: decoder)
      self = .musicVideo(musicVideo)
    case .albums:
      let album = try Album(from: decoder)
      self = .album(album)
    case .artists:
      let artist = try Artist(from: decoder)
      self = .artist(artist)
    }
  }
}
