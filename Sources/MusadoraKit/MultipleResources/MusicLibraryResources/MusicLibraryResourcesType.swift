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

  /// The key identifying the type of library resource for API requests.
  public enum Key: String, Codable {
    /// Library songs resource key.
    case songs = "library-songs"
    /// Library albums resource key.
    case albums = "library-albums"
    /// Library playlists resource key.
    case playlists = "library-playlists"
    /// Library artists resource key.
    case artists = "library-artists"
    /// Library music videos resource key.
    case musicVideos = "library-music-videos"

    /// The formatted type string for use in API query parameters.
    public var type: String {
      "ids[\(rawValue)]".removingPercentEncoding ?? "ids[\(rawValue)]"
    }
  }
}

extension MusicLibraryResourcesType: MusicItem {
  /// The unique identifier for the library resource.
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
