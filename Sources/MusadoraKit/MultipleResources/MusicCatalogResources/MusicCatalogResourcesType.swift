//
//  MusicCatalogResourcesType.swift
//  MusicCatalogResourcesType
//
//  Created by Rudrank Riyam on 23/04/22.
//

/// A collection of music catalog resources types.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
typealias MusicCatalogResourcesTypes = MusicItemCollection<MusicCatalogResourcesType>

/// A generic music item to represent each of the catalog music items.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public enum MusicCatalogResourcesType {
  case station(Station)
  case genre(Genre)
  case song(Song)
  case recordLabel(RecordLabel)
  case playlist(Playlist)
  case artist(Artist)
  case album(Album)
  case curator(Curator)
  case radioShow(RadioShow)
  case musicVideo(MusicVideo)

  public enum Key: String, Codable {
    case stations
    case genres
    case songs
    case recordLabels = "record-labels"
    case playlists
    case artists
    case albums
    case curators
    case radioShows = "apple-curators"
    case musicVideos = "music-videos"

    public var type: String {
      "ids[\(rawValue)]".removingPercentEncoding ?? "ids[\(rawValue)]"
    }
  }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogResourcesType: MusicItem {
  public var id: MusicItemID {
    let id: MusicItemID

    switch self {
    case let .station(station): id = station.id
    case let .genre(genre): id = genre.id
    case let .song(song): id = song.id
    case let .recordLabel(recordLabel): id = recordLabel.id
    case let .playlist(playlist): id = playlist.id
    case let .artist(artist): id = artist.id
    case let .album(album): id = album.id
    case let .curator(curator): id = curator.id
    case let .radioShow(radioShow): id = radioShow.id
    case let .musicVideo(musicVideo): id = musicVideo.id
    }

    return id
  }
}

@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
extension MusicCatalogResourcesType: Decodable {
  enum CodingKeys: CodingKey {
    case type
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let type = try values.decode(MusicCatalogResourcesType.Key.self, forKey: .type)

    switch type {
    case .songs:
      let song = try Song(from: decoder)
      self = .song(song)
    case .playlists:
      let playlist = try Playlist(from: decoder)
      self = .playlist(playlist)
    case .stations:
      let station = try Station(from: decoder)
      self = .station(station)
    case .musicVideos:
      let musicVideo = try MusicVideo(from: decoder)
      self = .musicVideo(musicVideo)
    case .radioShows:
      let radioShow = try RadioShow(from: decoder)
      self = .radioShow(radioShow)
    case .curators:
      let curator = try Curator(from: decoder)
      self = .curator(curator)
    case .genres:
      let genre = try Genre(from: decoder)
      self = .genre(genre)
    case .albums:
      let album = try Album(from: decoder)
      self = .album(album)
    case .recordLabels:
      let recordLabel = try RecordLabel(from: decoder)
      self = .recordLabel(recordLabel)
    case .artists:
      let artist = try Artist(from: decoder)
      self = .artist(artist)
    }
  }
}
