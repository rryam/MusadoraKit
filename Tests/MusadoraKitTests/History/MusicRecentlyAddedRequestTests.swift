@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct MusicRecentlyAddedRequestTests {
  @Test
  func recentlyAddedAlbumRequestFiltersAlbums() throws {
    let album = try Album.mock
    let song = try Song.mock
    let items: [UserMusicItem] = [
      .album(album),
      .track(.song(song))
    ]

    let request = MusicRecentlyAddedRequest<Album>()
    let filteredItems = try request.filteredItems(from: items)

    #expect(filteredItems.count == 1)
    #expect(filteredItems.first?.id == album.id)
  }

  @Test
  func recentlyAddedSongRequestFiltersSongsFromTracks() throws {
    let album = try Album.mock
    let song = try Song.mock
    let station = try Station.mock
    let items: [UserMusicItem] = [
      .album(album),
      .track(.song(song)),
      .station(station)
    ]

    let request = MusicRecentlyAddedRequest<Song>()
    let filteredItems = try request.filteredItems(from: items)

    #expect(filteredItems.count == 1)
    #expect(filteredItems.first?.id == song.id)
  }

  @Test
  func recentlyAddedTrackRequestKeepsTracks() throws {
    let song = try Song.mock
    let station = try Station.mock
    let items: [UserMusicItem] = [
      .track(.song(song)),
      .station(station)
    ]

    let request = MusicRecentlyAddedRequest<Track>()
    let filteredItems = try request.filteredItems(from: items)

    #expect(filteredItems.count == 1)
    #expect(filteredItems.first?.id == song.id)
  }
}
