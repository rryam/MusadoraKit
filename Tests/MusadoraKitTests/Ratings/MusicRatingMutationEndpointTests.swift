@testable import MusadoraKit
import MusicKit
import Testing

@Suite struct MusicRatingMutationEndpointTests {
  @Test func catalogRatingAddEndpoint() throws {
    let request = MCatalogRatingAddRequest(with: MusicItemID("123"), item: .song, rating: .like)
    let url = try request.catalogAddRatingsEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/ratings/songs/123")
  }

  @Test func catalogRatingDeleteEndpoint() throws {
    let request = MCatalogRatingDeleteRequest(with: MusicItemID("999"), item: .album)
    let url = try request.catalogDeleteRatingsEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/ratings/albums/999")
  }

  @Test func libraryRatingAddEndpoint() throws {
    let request = MLibraryRatingAddRequest(with: MusicItemID("42"), item: .song, rating: .like)
    let url = try request.libraryAddRatingsEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/ratings/library-songs/42")
  }

  @Test func libraryRatingDeleteEndpoint() throws {
    let request = MLibraryRatingDeleteRequest(with: MusicItemID("77"), item: .playlist)
    let url = try request.libraryDeleteRatingsEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/ratings/library-playlists/77")
  }
}
