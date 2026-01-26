@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct FavoritesEndpointTests {
  @Test
  func favoriteSingleSongEndpoint() throws {
    let request = MusicFavoritesRequest(itemID: MusicItemID("123"), resourceType: .songs)
    let url = try request.favoritesEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/favorites?ids[songs]=123")
  }

  @Test
  func favoriteMultipleResourcesEndpoint() throws {
    let ids: [MusicItemID] = ["1", "2", "3"]
    let request = MusicFavoritesRequest(itemIDs: ids, resourceType: .albums)
    let url = try request.favoritesEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/favorites?ids[albums]=1,2,3")
  }

  @Test
  func favoriteEmptyResourcesThrows() throws {
    let request = MusicFavoritesRequest(itemIDs: [], resourceType: .songs)

    let error = #expect(throws: MusadoraKitError.self) {
      try request.favoritesEndpointURL
    }

    #expect(error == MusadoraKitError.idMissing)
  }
}
